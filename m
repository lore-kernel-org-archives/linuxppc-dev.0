Subject: Re: 2.6.6 kernel oops on ifconfig eth0 mtu 1300
From: Soeren Sonnenburg <kernel@nn7.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1084669527.6444.2.camel@gaston>
References: <1084643442.4708.3.camel@localhost>
	 <1084669527.6444.2.camel@gaston>
Content-Type: text/plain
Message-Id: <1084693466.4708.18.camel@localhost>
Mime-Version: 1.0
Date: Sun, 16 May 2004 09:44:28 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-05-16 at 03:05, Benjamin Herrenschmidt wrote:
> On Sun, 2004-05-16 at 03:50, Soeren Sonnenburg wrote:
> > Hi.
> >
> > When I have some ethernet connection and then do
> > ifconfig eth0 mtu 1300 I get an immediate kernel panic (kernel 2.6.6)
> > powerbook g4 15" 1ghz.
> >
> > (xmon trace (jpeg) on request)
>
> Yes, please, the trace

doesn't it happen when you do ifconfig eth0 mtu 1300 ? anyway here it
is: use a web-browser to view it (it is a redirect):
http://www.nn7.de/kernel/mtu1300.jpg

Soeren


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
