Return-Path: <SRS0=bRT9=RF=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 15722DDEE0
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 16:53:58 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 19/20] [POWERPC] pci32: 4xx embedded platforms want to
	reassign all PCI resources
Date: Fri, 14 Dec 2007 06:48:41 +0100
References: <20071213073851.C321FDDFC9@ozlabs.org>
	<1197581846.15741.183.camel@pasglop>
	<20071213155946.0e0c39a0@weaponx>
In-Reply-To: <20071213155946.0e0c39a0@weaponx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712140648.41873.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 13 December 2007, Josh Boyer wrote:
> > Keeping your embedded design tiny (and thus your own BSP) is one thing,
> > but adding ifdef's all over the place so that somebody can tinify an
> > eval board, I'm less sure about this... but if you want, you can fixup
> > my patches.
>
> I'm not really advocating for ifdefs.  If it annoys me enough (which I
> doubt it will), then I'd try to come up with some way to avoid those
> too.  For now, I think selecting PCI in Kconfig for those boards is OK.

Yes, I think it is OK to select it this way an those boards since they are 
evaluation boards with PCI slots.

Ciao,
Stefan
