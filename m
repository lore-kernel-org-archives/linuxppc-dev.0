Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id 7C6B0DE0AF
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 01:30:53 +1000 (EST)
Message-ID: <4880B730.8050801@scram.de>
Date: Fri, 18 Jul 2008 17:30:56 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCHv3 1/2] [POWERPC] CPM2: Implement GPIO LIB API on CPM2
	Freescale SoC.
References: <4808D75B.9000002@scram.de>
	<200806131715.59345.laurentp@cse-semaphore.com>
	<48593E56.70708@scram.de>
	<200806181908.41525.laurentp@cse-semaphore.com>
	<8D84340F-427C-403B-8121-481642478B8C@kernel.crashing.org>
In-Reply-To: <8D84340F-427C-403B-8121-481642478B8C@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

> On Jun 18, 2008, at 12:08 PM, Laurent Pinchart wrote:
> 
>> +#if defined(CONFIG_CPM2) || defined(CONFIG_8xx_GPIO)
>> +
>> +struct cpm2_ioports {
>> +	u32 dir, par, sor, odr, dat;
>> +	u32 res[3];
>> +};
>> +
> 
> is this really common for both CPM2 and 8xx?  if so why the name?

It is common to CPM2 and Port E of CPM1.

Thanks,
Jochen
