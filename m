Message-ID: <3D64C445.836C2FC9@opensource.se>
Date: Thu, 22 Aug 2002 13:00:21 +0200
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: John.Fisher@nec.com.au
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cygwin and embedded linux
References: <000501c24979$6348a190$37d34c93@neca.nec.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Are there others in this situation and how have they chosen to solve it?

Vmware could be one way to solve it. Good if you want to develop and
test
device drivers.

Or use separate Linux boxes and use a X server to connect to them.
There are commercial X servers for Windows like X-Win32 and it should
also be possible to use Xfree86 on Windows for free. Both work great.

That way you can stay on Windows for a while, use the X-Server to access
the Linux box (and other boxes that supports X), and then maybe later
switch to a Linux-only solution.

Another way to solve it would be to switch to Linux and use VNC to
connect
to your Windows boxes. I'm not sure how well this works out, though.

/ magnus

> John Fisher wrote:
>
> > Actually, my personal opinion on that matter is that I'm not very fond
> > of using Windows for a Linux kernel development platform. Doing --
>
> So what are the issues: How is cygwin significantly different from Linux
> that you would not want to use it?
> Are there useful tools that run under Linux but not under cygwin?
>
> The reason I ask is that my organization currently does its software
> development under windows using proprietary tools. We have to maintain our
> existing products using these tools. We are however contemplating new
> development using linux. If we have to dual boot our PCs or have an extra PC
> running Linux for each developer, that is going to bring its own set of
> nuisances and problems.
>
> Are there others in this situation and how have they chosen to solve it?
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
