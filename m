Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87E36B7CC2
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 19:52:49 +1100 (EST)
Message-ID: <51131.84.105.60.153.1269593558.squirrel@gate.crashing.org>
In-Reply-To: <43c137a81003251901h229b873bh7593c59a5ef66ae9@mail.gmail.com>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
	<1269505301.8599.238.camel@pasglop> <201003251105.10033.arnd@arndb.de>
	<43c137a81003250800n660195c5k42c8516068aeda8d@mail.gmail.com>
	<1269549524.8599.243.camel@pasglop>
	<43c137a81003251811s52ac72eaud921d187e9747098@mail.gmail.com>
	<50253.84.105.60.153.1269566569.squirrel@gate.crashing.org>
	<43c137a81003251901h229b873bh7593c59a5ef66ae9@mail.gmail.com>
Date: Fri, 26 Mar 2010 09:52:38 +0100 (CET)
Subject: Re: Continual reading from the PowerPc time base register is not  
	stable
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Csdncannon" <csdncannon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[please do not top-post]

>> Do you now ever get two consecutive time readings that are closer
>> that 64 tick together?  If not, it's simply hiding the problem.
>>
>> Do you ever now read a value that does not have the bit with value
>> 0x40 set?

> I enabled the printing of all values. There is bigger gap between two
> reading, it seems isync bring to performance drop.

Yes exactly, which is to be expected.

> Could you elaborate what does "closer that 64 tick together" mean?

It means I cannot type -- "closer than 64 ticks".

My concern was that the sync;isync thing might slow down things
so much that you always get readings 64 or more cycles apart.
But you don't.

> You can see the attached log, the 0x40 is not always set.

Yes indeed.  Could you post the relevant piece if disassembly from
your original binary (the one that has the problem)?  Or send me the
binary (not to the mailing list), I'll do it then.


Segher
