Date: Mon, 3 Feb 2003 14:11:40 -0600 (CST)
From: vinai <vroopcha@mcw.edu>
To: Brad Sawatzky <brad+linuxppc@lamorak.phys.virginia.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Mach64-GX using fbdev problem
In-Reply-To: <20030203190143.GB20673@lamorak.phys.virginia.edu>
Message-ID: <Pine.LNX.4.44.0302031405460.269-100000@kaiso.biophysics.mcw.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I don't have a GX, but I do have a PCI Mach 64 Rage Pro running in 1280
x 1024 at 15 bits under Woody.  Here's my equivalent info:

>   Blue&White G3, kernel 2.4.20-ben1

2.4.18 from kernel.org

>   XFree86 Version 4.2.1.1 (Debian 4.2.1-5 20030121181741
>   branden@debian.org)/ X Window System
>   (protocol Version 11, revision 0, vendor release 6600)
>   Release Date: 18 October 2002

XFree86 Version 4.1.0.1 / X Window System
(protocol Version 11, revision 0, vendor release 6510)
Release Date: 21 December 2001

> From lspci:
>   01:03.0 VGA compatible controller: ATI Technologies Inc 210888GX
>           [Mach64 GX] (rev 03)

00:0e.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro
        (rev 5c) (prog-if 00 [VGA])

> From XF86Config
> Section "Device"
>         Identifier      "Mach64-GX"
>         Driver          "fbdev"
>         BusID           "PCI:1:3:0"
>         Option          "UseFBDev"              "true"
>         Option          "fbdev"                 "/dev/fb1"
> EndSection

Section "Device"
        Identifier      "ATI Rage"
        Driver          "ati"
        BusID           "PCI:0:14:0"
        Option          "UseFBDev"              "true"
EndSection

I think this might be where your card is failing - try the "ati" driver
and see if that helps.

cheers
vinai


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
