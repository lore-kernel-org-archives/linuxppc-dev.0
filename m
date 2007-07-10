Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 467CBDDF05
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 23:21:39 +1000 (EST)
In-Reply-To: <fa686aa40707091548h5182d6d0r900afc1f35d4f80f@mail.gmail.com>
References: <200707092235.l69MZRnh015324@ld0164-tx32.am.freescale.net>
	<fa686aa40707091548h5182d6d0r900afc1f35d4f80f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A9B90D06-77BD-49B5-8D2D-300641A973BC@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2][POWERPC] document ipic level/sense info
Date: Tue, 10 Jul 2007 15:21:28 +0200
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Stuart Yoder <b08248@freescale.com>, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +Sense and level information follows the Linux convention
>> +(specified in include/linux/interrupt.h) and should be encoded
>> +as follows:
>> +
>> +       2 =  high to low edge sensitive type enabled
>> +       8 =  active low level sensitive type enabled

> ... but it is probably worthwhile commentting that sense types 1 & 4
> are not supported; just to fill in the obvious gaps.  :-)

Same for sense types 0, 3, 5, 6, ...

Just name the sense types 0 and 1, similar to what all other
OF interrupt controller bindings do.


Segher
