Subject: Re: XV lockups with SMP 2.4.19-rc1-ben0
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Henry Worth <haworth15@attbi.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3D2A09D1.3080700@attbi.com>
References: <3D2A09D1.3080700@attbi.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: 08 Jul 2002 23:57:52 +0200
Message-Id: <1026165472.1263.654.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2002-07-08 at 23:53, Henry Worth wrote:
>
> Since rsyncing to Ben's 2.4.19-rc1-benh yesterday (and today), I have not
> been able to build an SMP kernel with working XV. System is AGP dual
> PowerMac
> with 450MHz 7400's, Rage 128, XFree85 4.2.0 and YDL 2.2. Kernels built with
> Ben's config and and minimal change for SMP (I've tried distributed and
> non-distribured rupts). I had SMP and XV working with Xine from a Saturday
> rsync, but not since rsync'ing yesterday or today (and I saved and tried
> the same config that had worked). All builds are mrproper. It looks like
> there have been some changes in some DRM and FB header files, but I didn't
> save the previous version to diff against
>
> XV will work with Xine when built as a non-SMP kernel, but an SMP kernel
> will lock-up almost instantly after hitting the Xine play button with dual
> processors and after a couple of seconds with a single CPU (maxcpus=1).
>
> After lockup I can usually telnet in to reboot, but not always (usually
> the screen blanks or loses sync in these cases). Haven't had any success
> trying to kill and restart the X server as can usual be done with X server
> hangs.

This is very likely related to DRI. Disable it or start a second server
with it disabled for Xv or try
http://www.penguinppc.org/~daenzer/XFree86-4.2/patches/r128-optiondmaforxv.diff


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
