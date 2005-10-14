Return-Path: <i2a@gmx.net>
Received: from mx102.multikabel.net (mx102.multikabel.net [212.127.254.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3FACD68564
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Oct 2005 01:34:25 +1000 (EST)
Received: from vmx100.multikabel.net ([212.127.254.147])
	by mx102.multikabel.net with esmtp (Exim 4.54) id 1EQRZc-00049g-4i
	for linuxppc-dev@ozlabs.org; Fri, 14 Oct 2005 17:34:20 +0200
Received: from sun.nodomain.nl (84-104-47-99.cable.quicknet.nl [84.104.47.99])
	by vmx100.multikabel.net (8.13.3/8.13.3) with ESMTP id j9EFYDoD021407
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2005 17:34:19 +0200
From: "i2a" <i2a@gmx.net>
To: linuxppc-dev@ozlabs.org
Date: Fri, 14 Oct 2005 17:34:15 +0200
Message-Id: <20051014145644.M46291@gmx.net>
In-Reply-To: <f308ce32868b18c6be30cf2a28d86ade@kernel.crashing.org>
References: <20051014115753.M37114@quicknet.nl>
	<f308ce32868b18c6be30cf2a28d86ade@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Subject: Re: open firmware
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 14 Oct 2005 15:17:47 +0200, Segher Boessenkool wrote
> > The linuxppc kernel uses the open firmware to access the ppc machine 
> > infos, I
> > want to be able to program to the open firmware to. Although there is 
> > a lost of
> > info inside the ppc kernel I still want to know the internals 
> > (definitions etc)
> > of [WINDOWS-1252?]“open [WINDOWS-1252?]firmware”.
> >
> > Has someone documentation available? On inet I only found the UI 
> > description :(
> 
> See http://playground.sun.com/1275/
> 
> Segher

Thanks, initially I had no luck with this site (I had find it),
http://playground.sun.com/1275/home.html#OFDCoreDoc

The two links of the core documentation are dead :(, and there has to be a way
to get the documentation without having to buy “the book”.


But here it is, via this page http://www.firmworks.com/www/ieee.htm
I got to ftp://playground.sun.com/pub/p1275/coredoc/ where the coredoc is
downloadable (it is old, but better then nothing), no idea why there are no
pointers to it..

If someone has any newer documentation pls let me know, the system I use is from
2004.

Grts,
  Ingmar
