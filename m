Message-ID: <3B71369C.A19FA1A2@seranoa.com>
Date: Wed, 08 Aug 2001 08:54:52 -0400
From: Andrew Dixon <andrew.dixon@seranoa.com>
MIME-Version: 1.0
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Strange bootpd behavior (server side)
References: <3B703ADA.9ADAFBAD@carts.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Check out the NAG:
	http://www.linuxdoc.org/LDP/nag2/index.html
and there are probably a bunch of mail lists for Red Hat Network
Administration.  I can't recommend one because I use Debian.  (If you
want to upgrade your server from Dead Rat to Debian though
debian-user@lists.debian.org is a great list ;)

later,
Andy


Kevin Fry wrote:
>
> I'm having a small problem with our redhat 6.2 bootp server and maybe
> yous guys can shed some light on it for me.   The problem is that
> whenever our DSL internet connection is down(which is too much.. I wish
> cable was available!), the bootpd stops responding to requests.. I can
> see the requests with tcpdump, but no replys. and when the internet is
> up sometimes is takes a little bit for the bootpd to respond to
> requests.
>     I think it's doing DNS resolution and if it can't find a DNS server
> when the net's down, it just stops working. Does linux automatically do
> name resolution on every address it gets? If so can i turn this off?
>     Our network is behind a DSL modem/router (Flowpoint 2200) acting as
> gateway(192.168.254.254), and we have 3 switches after that.
>     A lot of the time the router is finicky with linux even when
> everything is working.. I know this is a bit off topic, but ANY
> suggestions are very welcome.
>
> Here's my routing table..
>
> Kernel IP routing table
> Destination     Gateway         Genmask         Flags Metric Ref    Use
> Iface
> 192.168.254.13 *                   255.255.255.255 UH    0      0
> 0 eth0
> 192.168.254.0   *                   255.255.255.0   U     0
> 0        0 eth0
> 127.0.0.0       *                       255.0.0.0       U     0
> 0        0 lo
> default    192.168.254.254    0.0.0.0         UG    0      0        0
> eth0
>
> Thanks!
> Kevin Fry
>

--
Andrew Dixon
Software Engineer
Seranoa Networks
978.897.3434 x231

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
