Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 062F0DE04E
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 10:31:18 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8B0VFhs016641
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 20:31:15 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8B0VFcu229714
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 20:31:15 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8B0VEbC015185
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 20:31:14 -0400
Date: Wed, 10 Sep 2008 20:31:00 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Prodyut Hazarika" <phazarika@amcc.com>
Subject: Re: Question on 4xx GIT tree
Message-ID: <20080910203100.6c0bf2d5@zod.rchland.ibm.com>
In-Reply-To: <0CA0A16855646F4FA96D25A158E299D605014C18@SDCEXCHANGE01.ad.amcc.com>
References: <0CA0A16855646F4FA96D25A158E299D604F7F1A4@SDCEXCHANGE01.ad.amcc.com>
	<20080908173509.7cccdbc7@zod.rchland.ibm.com>
	<0CA0A16855646F4FA96D25A158E299D604F7F1E1@SDCEXCHANGE01.ad.amcc.com>
	<20080908193856.0cfd1c86@zod.rchland.ibm.com>
	<0CA0A16855646F4FA96D25A158E299D605014C18@SDCEXCHANGE01.ad.amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 10 Sep 2008 16:47:48 -0700
"Prodyut Hazarika" <phazarika@amcc.com> wrote:

> Hi Josh,
> I have few questions.
> 
> > > Should I base my patch from your master branch or your 'next' branch?
> > The 'next' branch would be best.
> 
> I saw that both your master and next branches have removed the 4xx dma and USB drivers.
> The dma drivers for 4xx used to under: drivers/dma/ppc440spe-adma.c
> The usb driver for 4xx used to be under: drivers/usb/gadget/dwc_otg/*
> The whole dwc_otg directory got removed.

Those drivers were never in any version of the upstream kernel
according to git.

[jwboyer@yoda linux-2.6]$ git checkout master
Switched to branch "master"
[jwboyer@yoda linux-2.6]$ git log -- drivers/dma/ppc440spe-adma.c
[jwboyer@yoda linux-2.6]$ git log -- drivers/usb/gadget/dwc_otg
[jwboyer@yoda linux-2.6]$

> Do you know the reason why these drivers were removed? Also, are there plans to get these drivers back?
> Please let me know.

Perhaps they are in the DENX kernel?  If so, someone would need to
submit them for inclusion.

josh
