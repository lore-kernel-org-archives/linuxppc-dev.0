Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id A5791DDF1D
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 01:53:41 +1000 (EST)
Message-ID: <4720BBE9.80108@semihalf.com>
Date: Thu, 25 Oct 2007 17:53:13 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 09/11] [POWERPC] Motion-PRO: Add LED support.
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>	<20071023231358.29359.90259.stgit@hekate.izotz.org>
	<fa686aa40710240718t202a8d14lab24f11e8d53e0eb@mail.gmail.com>
In-Reply-To: <fa686aa40710240718t202a8d14lab24f11e8d53e0eb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
...
>> +
>> +static int __init mpled_init(void)
>> +{
>> +       int i, error;
>> +
>> +       for (i = 0; i < sizeof(led) / sizeof(struct motionpro_led); i++){
>> +               led[i].reg_addr = mpc52xx_find_and_map(led[i].reg_compat);
> 
> Please use of-platform-bus bindings instead.  Let the of-platform bus
> take care of scanning the tree for you.  Don't do it manually.

Hm, let me try that instead, thanks for the suggestion.

Cheers,
m.
