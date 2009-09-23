Return-Path: <jacmet@gmail.com>
Received: from mail-fx0-f214.google.com (mail-fx0-f214.google.com
	[209.85.220.214]) by ozlabs.org (Postfix) with ESMTP id C4748B7B7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Sep 2009 21:04:39 +1000 (EST)
Received: by fxm10 with SMTP id 10so485923fxm.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Sep 2009 04:04:36 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: Johnny Hung <johnny.hacking@gmail.com>
Subject: Re: GPIO driver for MPC8313.
References: <cb9ecdfa0909222055x1d691698sb516b5b8f5f81d@mail.gmail.com>
	<87y6o6rvvc.fsf@macbook.be.48ers.dk>
	<cb9ecdfa0909230352w77a37f59h3c7f1e146121f9f6@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 23 Sep 2009 13:04:32 +0200
In-Reply-To: <cb9ecdfa0909230352w77a37f59h3c7f1e146121f9f6@mail.gmail.com>
	(Johnny Hung's message of "Wed\, 23 Sep 2009 18\:52\:24 +0800")
Message-ID: <87r5txrkfz.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Johnny" == Johnny Hung <johnny.hacking@gmail.com> writes:

 Johnny> Thanks, got it. BTW, how to trigger GPIO level in user space
 Johnny> application? I also found
 Johnny> arch/powerpc/platforms/52xx/mpc52xx_gpio.c is a good
 Johnny> example. Any reply is appreciate.

Through sysfs. See 'Sysfs Interface for Userspace' section of
Documentation/gpio.txt

-- 
Bye, Peter Korsgaard
