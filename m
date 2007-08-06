Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 97F20DDE1F
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 05:01:57 +1000 (EST)
In-Reply-To: <5C596943-5C01-4097-940C-29FF46E49BA7@kernel.crashing.org>
References: <20070802173335.GA25369@localhost.localdomain>
	<20070802173536.GA25643@localhost.localdomain>
	<5C596943-5C01-4097-940C-29FF46E49BA7@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dc2e2d57444f90b10fdda30fada2ed4f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 1/2] [RFC][POWERPC] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Date: Mon, 6 Aug 2007 21:01:51 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +			mmc@0 {
>> +				reg = <0>;
>> +				pio-handle = <&mmc0pio>;
>> +			};
>>  		};
>
> I'm still against this.  Why don't we just do this in 
> 83xx/mpc832x_rdb.c

Seconded.


Segher
