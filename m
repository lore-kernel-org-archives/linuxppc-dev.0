Date: Mon, 24 Jul 2000 10:12:09 -0400 (EDT)
From: John Grimes <jpgrimes@johngrimes.dyndns.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Xfree86 version 4.01
In-Reply-To: <Pine.LNX.4.21.0007240938040.11526-100000@dyn-133-196.gordon.edu>
Message-ID: <Pine.LNX.4.21.0007240959001.1920-100000@johngrimes.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Decided to try Xfree86 version 4 again (it had been a few
months).  Recompiled, fixed up XF86Config and amazingly I now have 24 bit
color, 1280x1024, r128 accelerated X.  It is decidely faster than Xpmac
and its a great start.

But I want more :)

For some reason I can not get any other mode to work
(i.e. 640x480,1024x768, 800x600).  If any would fail I would expect it to
be 1280x1024 not the smaller modes.  I have no modelines defined, just
letting XF86 decided which modes to use.  Any ideas why the defaults don't
work?

Next is getting multiple monitors (Xinema) to work.  I know there has
been
discussion of this on the list.

First how do I find out the bus address of my internal video?  It doesn't
show up in /proc/pci although it is in /proc/fb.  This is on a
highly upgraded powercenter.

Also, I seem to have not saved it as I had thought, but does anyone have
an example XF86Config file for multiple monitors?

Congrats to the people who have worked on this, it is definetely an
improvement.

							john





On Mon, 24 Jul 2000, Peter R. Wood wrote:

>
> Regarding my last message, please Cc: any replies to me, as I am receiving
> in digest mode. Thanks.
>
> Peter
>
> --
> Peter R. Wood          pwood@gordon.edu
> Computer Science       | Lightning    |
> Gordon College         | Samurai      |
> Wenham, MA             | Action!!!!!! |
>
>
>

--
           John Grimes - Mission Planner for Chandra X-Ray Telescope
Phone 	(H) 617-591-1393	(W) 617-496-7663	(Fax) 617-495-7356
Email 	me@johngrimes.com	Web	http://www.johngrimes.com
Pager	1-800-473-6312 		Alphanumeric  4736312@mobilecomm.net)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
