Message-ID: <3B705B22.366AE18F@adtran.com>
Date: Tue, 07 Aug 2001 16:18:26 -0500
From: Ron Flory <ron.flory@adtran.com>
MIME-Version: 1.0
To: Kevin Fry <kevin@carts.com>
Cc: linuxppc emb3dd3d list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Strange bootpd behavior (server side)
References: <3B703ADA.9ADAFBAD@carts.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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

 it sounds like 'fun with PAM' that causes similar problems with my
TFTP server.  I need to write a simple inetd replacement (sans PAM)
just for TFTP, so we don't get killed by the delays caused by PAM
authorization checks.

ron

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
