From: Benjamin Herrenschmidt <bh40@calva.net>
To: "Timothy A. Seufert" <tas@mindspring.com>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: BMAC+ & Full Duplex
Date: Fri, 19 May 2000 21:13:18 +0200
Message-Id: <20000519191318.30716@sjc2-relay.mail.digex.net>
In-Reply-To: <v04220801b54ab29142c2@10.0.0.42>
References: <v04220801b54ab29142c2@10.0.0.42>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, May 19, 2000, Timothy A. Seufert <tas@mindspring.com> wrote:

>I'm pretty sure your 1999 PowerBook uses the same BMAC+ Ethernet as
>his PowerMac G3.  The auto-sensing feature doesn't work with all
>Ethernet hubs/switches, which is why he's having problems and you
>aren't.
>
>I have a couple B&W G3s connected to a 5-port 100BaseT switch, and
>they successfully autonegotiate full duplex 100BaseT under both MacOS
>and Linux.

There are known auto-neg problems with Apple eth. chips. We should
provide a way to force the driver duplex and speed modes. I beleive an
ioctl along with a small command line tool would be cool, but maybe not
enough (a compile option or kernel command line args would help for
people netbooting).

I've not find "standard" ioctl I could implement for that, so I beleive
we just can invent a new one and add it to MACE, BMAC and GMAC drivers.
I'll look into this when I'm back along with some GMAC fixes.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
