Date: Tue, 30 Jan 2001 10:45:26 -0500
From: Josh Huber <huber@alum.wpi.edu>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Graphics corruption with XF
Message-ID: <20010130104526.B4903@missioncriticallinux.com>
References: <20010126133941.A7973@missioncriticallinux.com> <3A721E68.6E85EB0E@iiic.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3A721E68.6E85EB0E@iiic.ethz.ch>; from michdaen@iiic.ethz.ch on Sat, Jan 27, 2001 at 02:03:36AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 27, 2001 at 02:03:36AM +0100, Michel Dänzer wrote:
> Josh Huber wrote:
>
> > X reports that it could only find 1 MB of video memory, when I'm
> > pretty sure it's got 4 MB.  This of course severly limits my
> > depth/resolution, and when paired with the rage 128 I'm currently
> > using it's a little lacking.. :)
>
> man XF86Config, look for VideoRam.

Yes, even with this option I get 1MB of SGRAM used, which severly
limits my choices for resolutions.

> Anyone who has must have fixed the ati driver ;)
>
> I suppose it shouldn't be too hard to fix looking at the r128 or glint
> drivers.

heh, if only I had the time to look at this...

> Oh, BTW - have you tried Ani's rsync tree?

I haven't.  I'm in the process of downloading as I type this,
however...so we'll see how that goes.

--
Josh Huber
1024D/6B21489A 61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
