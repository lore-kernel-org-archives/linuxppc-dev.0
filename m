Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 5482FDDE1C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 00:53:18 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so282587uge
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 07:53:17 -0700 (PDT)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: cuImage generation
References: <20070919072831.322800@gmx.net>
	<20070919141953.GB8023@ld0162-tx32.am.freescale.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 19 Sep 2007 16:53:14 +0200
In-Reply-To: <20070919141953.GB8023@ld0162-tx32.am.freescale.net> (Scott
	Wood's message of "Wed\, 19 Sep 2007 09\:19\:53 -0500")
Message-ID: <87ps0elnad.fsf@macbook.be.48ers.dk>
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

 Scott> On Wed, Sep 19, 2007 at 09:28:31AM +0200, Gerhard Pircher wrote:
 >> I tried to compile a 2.6.23-rc6 kernel yesterday, but wasn't able to get a
 >> cuImage.<platform) out of it (only the uImage file was generated). My
 >> platform config defines DEFAULT_UIMAGE and WANT_DEVICE_TREE. Do I need to
 >> generate it manually or is there a makefile where I have to specify it?
 >> Naturally I added my cuboot wrapper code to the arch/powerpc/boot/Makefile.

I have the same problem here..

 Scott> Did you specify a device tree to use in CONFIG_DEVICE_TREE?

Yes.

% grep TREE .config
CONFIG_PROC_DEVICETREE=y
CONFIG_WANT_DEVICE_TREE=y
CONFIG_DEVICE_TREE="mpc8349emitx.dts"

How is it supposed to work now cuImage no longer is in BOOT_TARGETS?
What make target are you supposed to work. It works if I add
cuImage.83xx to BOOT_TARGETS and call make cuImage.83xx, but that can
hardly be the correct way?

-- 
Bye, Peter Korsgaard
