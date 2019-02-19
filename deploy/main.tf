provider "digitalocean" {
    token = "${var.token}"
}

resource "digitalocean_tag" "nginx" {
    name = "nginx"
}

resource "digitalocean_droplet" "nginx_server" {
    name = "my-blog"
    image = "43807247"
    size = "512mb"
    region = "sgp1"
    ipv6 = true
    private_networking = false
    tags = ["${digitalocean_tag.nginx.name}"]
    ssh_keys = ["f5:cf:ab:81:39:28:bb:a7:b2:03:b3:c2:b5:d2:84:84"]
}

resource "digitalocean_firewall" "webserver" {
    name = "webserver-firewall"
    droplet_ids = ["${digitalocean_droplet.nginx_server.id}"]

    inbound_rule = [
        {
            protocol = "tcp"
            port_range = "22"
        },
        {
            protocol = "tcp"
            port_range = "80"
        },
        {
            protocol = "tcp"
            port_range = "443"
        }
    ]

    outbound_rule = [
        {
            protocol = "tcp"
            port_range = "53"
        },
        {
            protocol = "udp"
            port_range = "53"
        }
    ]
}