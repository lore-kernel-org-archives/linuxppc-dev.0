Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id 6E6D5DE4AD
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 05:02:05 +1000 (EST)
Message-ID: <4877ADF6.8070702@scram.de>
Date: Fri, 11 Jul 2008 21:01:10 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of/i2c: don't pass -1 to irq_dispose_mapping,	otherwise
	kernel will oops
References: <20080711174859.GA24260@polina.dev.rtsoft.ru>
	<20080711182323.GB15321@secretlab.ca>
In-Reply-To: <20080711182323.GB15321@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: khali@linux-fr.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

> What is the reason that info.irq is set to -1 in the first place?  This
> looks like another bug to me.  Does something in the i2c layer depend on
> the -1 value?

Nope, it was a bug in the i2c documentation fixed recently:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8e29da9ee8958cc17e27f4053420f1c982614793

Thanks,
Jochen
