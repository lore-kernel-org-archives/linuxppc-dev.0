Return-Path: <jacmet@gmail.com>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.228])
	by ozlabs.org (Postfix) with ESMTP id E7303DDE2A
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 01:20:26 +1000 (EST)
Received: by hu-out-0506.google.com with SMTP id 24so83885hud
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 08:20:24 -0700 (PDT)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: cuImage generation
References: <20070919072831.322800@gmx.net>
	<20070919141953.GB8023@ld0162-tx32.am.freescale.net>
	<87ps0elnad.fsf@macbook.be.48ers.dk>
	<20070919150134.GA8249@ld0162-tx32.am.freescale.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 19 Sep 2007 17:20:23 +0200
In-Reply-To: <20070919150134.GA8249@ld0162-tx32.am.freescale.net> (Scott
	Wood's message of "Wed\, 19 Sep 2007 10\:01\:34 -0500")
Message-ID: <87lkb2lm14.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Scott" == Scott Wood <scottwood@freescale.com> writes:

 Scott> On Wed, Sep 19, 2007 at 04:53:14PM +0200, Peter Korsgaard wrote:
 >> How is it supposed to work now cuImage no longer is in BOOT_TARGETS?
 >> What make target are you supposed to work. It works if I add
 >> cuImage.83xx to BOOT_TARGETS and call make cuImage.83xx, but that can
 >> hardly be the correct way?

 Scott> Ah, OK -- you need to type make zImage, not make uImage.

Ahh, I got fooled by the platform selecting DEFAULT_UIMAGE - Thanks!

-- 
Bye, Peter Korsgaard
