Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 36972DDE1F
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 01:25:55 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 19 Sep 2007 17:25:53 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <87lkb2lm14.fsf@macbook.be.48ers.dk>
Message-ID: <20070919152553.310380@gmx.net>
MIME-Version: 1.0
References: <20070919072831.322800@gmx.net>
	<20070919141953.GB8023@ld0162-tx32.am.freescale.net>
	<87ps0elnad.fsf@macbook.be.48ers.dk>
	<20070919150134.GA8249@ld0162-tx32.am.freescale.net>
	<87lkb2lm14.fsf@macbook.be.48ers.dk>
Subject: Re: cuImage generation
To: Peter Korsgaard <jacmet@sunsite.dk>, scottwood@freescale.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Wed, 19 Sep 2007 17:20:23 +0200
> Von: Peter Korsgaard <jacmet@sunsite.dk>
> An: Scott Wood <scottwood@freescale.com>
> CC: Gerhard Pircher <gerhard_pircher@gmx.net>, linuxppc-dev@ozlabs.org
> Betreff: Re: cuImage generation

> >>>>> "Scott" == Scott Wood <scottwood@freescale.com> writes:
> 
>  Scott> On Wed, Sep 19, 2007 at 04:53:14PM +0200, Peter Korsgaard wrote:
>  >> How is it supposed to work now cuImage no longer is in BOOT_TARGETS?
>  >> What make target are you supposed to work. It works if I add
>  >> cuImage.83xx to BOOT_TARGETS and call make cuImage.83xx, but that can
>  >> hardly be the correct way?
> 
>  Scott> Ah, OK -- you need to type make zImage, not make uImage.
> 
> Ahh, I got fooled by the platform selecting DEFAULT_UIMAGE - Thanks!
I also thought I have to use "make uImage", because of DEFAULT_UIMAGE.

Thanks!

Gerhard
-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kanns mit allen: http://www.gmx.net/de/go/multimessenger
