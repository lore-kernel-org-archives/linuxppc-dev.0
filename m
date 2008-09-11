Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 28324DDF82
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 14:48:37 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Question on 4xx GIT tree
Date: Thu, 11 Sep 2008 06:48:31 +0200
References: <0CA0A16855646F4FA96D25A158E299D604F7F1A4@SDCEXCHANGE01.ad.amcc.com>
	<20080910203100.6c0bf2d5@zod.rchland.ibm.com>
	<0CA0A16855646F4FA96D25A158E299D605014C40@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <0CA0A16855646F4FA96D25A158E299D605014C40@SDCEXCHANGE01.ad.amcc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809110648.31267.sr@denx.de>
Cc: Prodyut Hazarika <phazarika@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 11 September 2008, Prodyut Hazarika wrote:
> > > Do you know the reason why these drivers were removed? Also, are there
> > > plans to get these drivers back? Please let me know.
> >
> > Perhaps they are in the DENX kernel?  If so, someone would need to submit
> > them for inclusion.
>
> Yes those drivers were in the Denx kernel.

Correct.

> I was in the impression that 
> they were in the mainline Linux tree too. I will try to get those drivers 
> submitted to the main Linux tree.

Great. But prepare for a lot of work to get the USB OTG driver into shape for 
upstream acceptance.

Best regards,
Stefan
