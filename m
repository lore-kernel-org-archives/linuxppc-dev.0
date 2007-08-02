Return-Path: <alfman@austin.rr.com>
Received: from ms-smtp-05.texas.rr.com (ms-smtp-05.texas.rr.com [24.93.47.44])
	by ozlabs.org (Postfix) with ESMTP id EAE61DDD0D
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 12:35:26 +1000 (EST)
From: "Alfred Manheim" <alfman@austin.rr.com>
To: "'Liu Dave-r63238'" <DaveLiu@freescale.com>,
	"'Phillips Kim-R1AAHA'" <Kim.Phillips@freescale.com>,
	"'Keith Mund'" <keith.mund@clearcube.com>
References: <20070801133056.GP3972@stusta.de>
	<fa686aa40708010653v7e1fb909gb03eb1d4754359bf@mail.gmail.com>
	<5EACFDEA24DADE42BF109303D305A8093120A6@MAIL.clearcube.com>
	<20070801192009.656fc2e0.kim.phillips@freescale.com>
	<995B09A8299C2C44B59866F6391D2635AAD0C5@zch01exm21.fsl.freescale.net>
In-Reply-To: <995B09A8299C2C44B59866F6391D2635AAD0C5@zch01exm21.fsl.freescale.net>
Subject: RE: [U-Boot-Users] MPC83xx - previous patch to set MBAR
Date: Wed, 1 Aug 2007 21:34:57 -0500
Message-ID: <000001c7d4ad$b83a07b0$28ae1710$@rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Cc: linuxppc-dev@ozlabs.org, u-boot-users@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This was to the wrong group.

Thanks for the responses and the clarification. The "needed for CodeWarrior
only" part is what I suspected.

Keith Mund

-----Original Message-----
From: linuxppc-dev-bounces+alfman=austin.rr.com@ozlabs.org
[mailto:linuxppc-dev-bounces+alfman=austin.rr.com@ozlabs.org] On Behalf Of
Liu Dave-r63238
Sent: Wednesday, August 01, 2007 9:15 PM
To: Phillips Kim-R1AAHA; Keith Mund
Cc: linuxppc-dev@ozlabs.org; u-boot-users@lists.sourceforge.net
Subject: RE: [U-Boot-Users] MPC83xx - previous patch to set MBAR

> > The end result simply adds a line to set MBAR to match IMMRBAR.
> > 
> >         lis     r3, CFG_IMMRBAR@h
> >         ori     r3, r3, CFG_IMMRBAR@l
> >         stw     r3, IMMRBAR(r4)
> > +       mtspr   MBAR, r3
> > 
> > Are these patches routinely added to the mainstream u-boot code? 
> > 
> > Is there any reason why this fix is not a good idea?
> > 
> does setting MBAR really fix anything?
> 
> MBAR doesn't live up to its name.  It's a general-purpose scratch 
> register - the hardware doesn't do anything with it.  So, wrt

Kim is right.

MBAR setting is added by two years ago, it is not really fix anything.

I set the MBAR to be easier to use the CodeWarriror. The CodeWarrior must
set the MBAR first, then it will be able to access the IMMR.

Dave
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
