Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB30EDDEBC
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 05:37:27 +1000 (EST)
In-Reply-To: <473A9535-CF43-4299-8D23-B97E50B5BEC3@kernel.crashing.org>
References: <200707092235.l69MZRnh015324@ld0164-tx32.am.freescale.net>
	<fa686aa40707091548h5182d6d0r900afc1f35d4f80f@mail.gmail.com>
	<A9B90D06-77BD-49B5-8D2D-300641A973BC@kernel.crashing.org>
	<473A9535-CF43-4299-8D23-B97E50B5BEC3@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <87E6FBC6-C668-4F0E-8CF8-11FA077522D6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2][POWERPC] document ipic level/sense info
Date: Tue, 10 Jul 2007 21:37:13 +0200
To: Kumar Gala <galak@kernel.crashing.org>
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

>>> ... but it is probably worthwhile commentting that sense types 1 & 4
>>> are not supported; just to fill in the obvious gaps.  :-)
>>
>> Same for sense types 0, 3, 5, 6, ...
>>
>> Just name the sense types 0 and 1, similar to what all other
>> OF interrupt controller bindings do.
>
> I'm not really keen on changing the values at this point.  I think  
> we are stuck with them.

Yeah, unless you create a new binding for the same hardware.
Not that I recommend that of course.  I suppose the lesson
is to document a device binding as soon as possible, not
months after the corresponding code and trees are out (or to
mark all such code/trees clearly as "preliminary").


Segher
