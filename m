Return-Path: <niklaus.giger@member.fsf.org>
Received: from viefep24-int.chello.at (viefep18-int.chello.at [213.46.255.22])
	by ozlabs.org (Postfix) with ESMTP id 27ECFDE011
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 04:51:23 +1000 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH]ppc4xx-Walnut: fixes early boot messages
Date: Thu, 2 Oct 2008 20:51:18 +0200
References: <200810020736.40736.niklaus.giger@member.fsf.org>
	<20081002063954.GR25598@yookeroo.seuss>
In-Reply-To: <20081002063954.GR25598@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810022051.18828.niklaus.giger@member.fsf.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Donnerstag 02 Oktober 2008 08.39:54 schrieb David Gibson:
> On Thu, Oct 02, 2008 at 07:36:40AM +0200, Niklaus Giger wrote:
> > Inherits the baudrate from U-boot to print things like:
> > Using Walnut machine description
> > Linux version <..>
> > console [udbg0] enabled
>
> Uh.. but what if you're booting from cuboot or openbios, rather than a
> device-tree-aware uboot.
Sorry. I forgot that you can have other boot-eprom beside U-Boot. I will try 
to fix that in my u-boot configuration.

Best regards

Niklaus
