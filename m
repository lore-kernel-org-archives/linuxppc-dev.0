Message-ID: <000a01c07601$5c3b7820$bf0102c8@sc.mcel.mot.com>
From: "Rolf Liu" <rolfl@sc.mcel.mot.com>
To: "Gary Thomas" <gthomas@redhat.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <XFMail.20010103201404.gthomas@redhat.com>
Subject: Re: separate kernel as code segment and data segment for linux p
Date: Thu, 4 Jan 2001 11:49:36 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


----- Original Message -----
From: Gary Thomas <gthomas@redhat.com>
To: Rolf Liu <rolfl@sc.mcel.mot.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Sent: Thursday, January 04, 2001 11:14 AM
Subject: RE: separate kernel as code segment and data segment for linux p


>
> On 04-Jan-2001 Rolf Liu wrote:
> >
> > Hi,all,
> > I am planning to run linux-ppc on ppc823 FADS board.
> > As all know, the kernel is resided in flash rom, then upon power-on,
kernel
> > is copied to RAM.
> > I wonder if I can just put data segment to ram and leave code segment to
> > FLASH, just as uClinux
> > has done. such method will save some ram space, which makes sense on
> > embedded solutions.
> > Can you give me a hint how to realize it ?
> > Any suggestion is appreciated !
>
> This method is called XIP (for execute in place) and is available on
> some other architectures.  I don't know what it would take for the PPC,
> but you could look at the work done on the Hitachi SH - I know it's
supported
> there.
Thanks a lot !
but where can I find the work about "Hitachi SH - " ?
Is there some data accessable through www ?
Best Regards


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
