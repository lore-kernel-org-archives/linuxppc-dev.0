Return-Path: <SRS0=wAAa=NA=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id BB790DDE05
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 22:23:22 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 5/6] PowerPC 440EPx: Sequoia board support
Date: Fri, 3 Aug 2007 14:25:19 +0200
References: <20070730151628.GA5100@ru.mvista.com>
	<200708030844.13895.sr@denx.de> <46B31352.1060503@ru.mvista.com>
In-Reply-To: <46B31352.1060503@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708031425.19475.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 03 August 2007, Valentine Barshak wrote:
> >> Should the 440GRX PVR additions be done in a separate patch?  Or is the
> >> PVR and cpu features truly the only difference between 440EPx and
> >> 440GRx?
> >
> > I think it makes sense to add the 440GRx with this patchset too. The
> > 440GRx is a subset of the 440EPx, missing some stuff like USB, FPU. And
> > the AMCC Rainier 440GRx eval board is a subset of the Sequoia eval board.
> > So no new board specific sources should be necessary to support the
> > Rainier, just a different defconfig file.
> >
> > Best regards,
> > Stefan
>
> I have a Rainier 440GRx board and the PVR is equal to the 440EPx one
> (0x200008D0). This has to be handled somehow, since the
> PPC_FEATURE_HAS_FPU flag should *not* be set for 440GRx.
> I'm really not sure how though. Any ideas are greatly appreciated :)
> Is it a h/w bug?

Depends on interpretation. IIRC currently the same die is used for 440EPx and 
440GRx. I could be wrong here though and it is just a bug in the chip. But 
anyway we should support this somehow. Could be that I missed this in the 
current 440GRx (Rainier) arch/ppc support too. I have to admit, that no 
clever solution comes to my mind right away though.

Best regards,
Stefan
