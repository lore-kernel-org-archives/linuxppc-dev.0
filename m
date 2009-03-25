Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79C6CDDFB3
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 14:47:44 +1100 (EST)
In-Reply-To: <1237928433.25062.725.camel@pasglop>
References: <20090316123543.GG15530@lisas.de>
	<1237868838.25062.712.camel@pasglop>
	<20090324114505.GB24724@lisas.de>
	<1237928433.25062.725.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D030DE57-7C4E-4DEE-BC5F-08B8A230F755@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix RTAS watchdog driver temperature read functionality
Date: Wed, 25 Mar 2009 04:49:27 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Right, now turn it into a proper patch submission :-)

>>  	if (result < 0)
>>  		printk(KERN_WARNING "wdrtas: reading the thermal sensor "
>> -		       "faild: %li\n", result);
>> +		       "faild: %i\n", result);
>>  	else
>>  		temperature = ((temperature * 9) / 5) + 32; /* fahrenheit */

Fix the spelling of "failed" while you're at it?  (And Fahrenheit  
maybe).


Segher
