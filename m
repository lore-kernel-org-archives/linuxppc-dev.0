Message-ID: <20020822032058.73464.qmail@web9501.mail.yahoo.com>
Date: Wed, 21 Aug 2002 20:20:58 -0700 (PDT)
From: Pete McCormick <pete261@yahoo.com>
Subject: RE: cygwin and embedded linux
To: John.Fisher@nec.com.au, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <000501c24979$6348a190$37d34c93@neca.nec.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> So what are the issues: How is cygwin significantly different from Linux
> that you would not want to use it?
> Are there useful tools that run under Linux but not under cygwin?
> The reason I ask is that my organization currently does its software
> development under windows using proprietary tools. We have to maintain our
> existing products using these tools. We are however contemplating new
> development using linux. If we have to dual boot our PCs or have an extra PC
> running Linux for each developer, that is going to bring its own set of
> nuisances and problems.

I am in a very similar situation as you.  I had a few problems doing things in
cygwin, things not building correctly, no genksyms for the kernel modules,
mount doesn't have all the options that the linux version does (for example
loopback file systems, useful for creating a ramdisk image.), etc.  So I feel
it is less desirable than a linux environment.

The solution that I am trying to implement in my current company is to do the
cross compiling on actual linux servers, using telnet or ssh from the windows
machines.  Running samba on the linux servers will let the windows people use
their current favorite programmer's editors.  If you install cygwin on the
windows machines, you can use their xwindows client Cygwin/XFree86 to run gui
applications remotely, if desired (e.g. DDD or Insight debuggers).


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
