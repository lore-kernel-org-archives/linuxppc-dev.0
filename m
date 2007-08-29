Return-Path: <SRS0=yXWv=N2=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 61620DDE2D
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 22:26:58 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/4] PowerPC 440EPx: Sequoia bootwrapper
Date: Wed, 29 Aug 2007 14:28:23 +0200
References: <20070828165321.GA1501@ru.mvista.com>
	<20070828130921.13809093@weaponx.rchland.ibm.com>
	<46D56226.8020500@ru.mvista.com>
In-Reply-To: <46D56226.8020500@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708291428.23522.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 29 August 2007, Valentine Barshak wrote:
> >> +#define DDR_GET_VAL(val, mask, shift)	(((val) >> (shift)) & (mask))
> >
> > Hm.  Having these as just DDR_... seems like it would lead to confusion
> > if there are other DDR controllers that get added later.  But I'm not
> > too picky either way.
>
> What names would you suggest? DDR_DENALI_... looks too long :)
> The names have been taken from the docs, I've just prefixed them with DDR_.

It's such a generic macro and not Denali or even SDRAM specific. So it really 
should be no problem to keep it as is.

Just my 0.02$.

Best regards,
Stefan
