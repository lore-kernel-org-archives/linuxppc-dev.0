Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1122ADDEFE
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 12:21:27 +1100 (EST)
In-Reply-To: <17818.64827.568060.143841@cargo.ozlabs.ibm.com>
References: <20070102172554.7a94cd37@mlejnas.priv.castalie.org>
	<535725c5c6010b6283b0ed0826dd469d@kernel.crashing.org>
	<20070102190944.70c19799@mlejnas.priv.castalie.org>
	<0e6a409d0ffedd23495d2aed672632dd@kernel.crashing.org>
	<17818.64827.568060.143841@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2d8333d72f58574b22339dfb29bc59a9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: R_PPC_ADDR16_HI relocs in PPC modules ?
Date: Wed, 3 Jan 2007 02:20:59 +0100
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Ah.  lis and ori.  HI16 is just fine there -- but note that
>> that doesn't use an add insn.  You're patching the function
>
> lis is an addis with rA=0, don't forget...

Heh true.  "I never forget that" ;-)

>> "apply_relocate_add()", so I guess some more work is needed?
>
> Looks fine as it is to me.

Looking at the bigger code, fine with me as well.  Confusing
names are in the nature of this relocation stuff (esp. when
you start adding those ELF-defined "names").


Segher
