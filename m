Subject: Re: ATI Rage Pro 128 TR
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: David Given <dg@tao-group.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <E16SjNP-0003T5-00@rhodium.tao.co.uk>
References: <E16SjNP-0003T5-00@rhodium.tao.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Date: 23 Jan 2002 17:20:53 +0100
Message-Id: <1011802853.820.1533.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2002-01-21 at 19:40, David Given wrote:
>
> Most screen modes make the screen go black; I suspect that the monitor's
> really a fixed-sync.

Yes, some iMacs' monitors seem to only accept modes with about 60 kHz
horizontal refresh.

> DirectFB programs cause certain programs, like syslogd, do go into D state
> --- I haven't worked out why yet. OTOH, this could be because DirectFB
> is trying to hardware accelerate the card.

Could this be the problem diagnosed by Andrew Morton as "the framebuffer
driver is failing to mark the mmapped vma as VM_IO, so the kernel is
trying to dump the framebuffer device to the core file, takes a
recursive fault and deadlocks." ?

http://kt.zork.net/kernel-traffic/kt20020114_150.html#2


> On a related note, is there a program that will reset the console back to
> text mode if my application crashes and leaves it in graphics mode anywhere?

fbset can be used to do all sorts of things with framebuffer devices. :)


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
