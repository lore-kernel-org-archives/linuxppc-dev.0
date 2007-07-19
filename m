Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CEF62DE6A4
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 01:05:16 +1000 (EST)
In-Reply-To: <20070718162240.557eea46@localhost.localdomain>
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<20070718013549.GJ15238@ld0162-tx32.am.freescale.net>
	<20070718162240.557eea46@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B8B0658B-8CF3-4E08-9BD7-EB022E1C9F9C@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 38/61] cpm2: Update device trees.
Date: Thu, 19 Jul 2007 17:04:55 +0200
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +				             "fsl,cpm-uart";
>>  				reg = <11a00 20 8000 100>;
>> -				current-speed = <1c200>;
> Hmm, how is it supposed to work without speed? I was testing my u- 
> boot OF bindings for 82xx and spotted into it.

"current-speed" cannot be a required property for serial
devices (it is only valid if the device is active at boot
time).


Segher
