Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 95AE4B7CBB
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 12:22:58 +1100 (EST)
Message-ID: <50253.84.105.60.153.1269566569.squirrel@gate.crashing.org>
In-Reply-To: <43c137a81003251811s52ac72eaud921d187e9747098@mail.gmail.com>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
	<1269505301.8599.238.camel@pasglop> <201003251105.10033.arnd@arndb.de>
	<43c137a81003250800n660195c5k42c8516068aeda8d@mail.gmail.com>
	<1269549524.8599.243.camel@pasglop>
	<43c137a81003251811s52ac72eaud921d187e9747098@mail.gmail.com>
Date: Fri, 26 Mar 2010 02:22:49 +0100 (CET)
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

> After trying the new code with "isync" and unsigned long long convertion,
> this problem doesn't happen(I tested for several minutes).

Do you now ever get two consecutive time readings that are closer
that 64 tick together?  If not, it's simply hiding the problem.

Do you ever now read a value that does not have the bit with value
0x40 set?


Segher
