Return-Path: <segher@kernel.crashing.org>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 617D567A46
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 01:07:01 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.12.10/8.12.10) with ESMTP id j2LDt30Q171330
	for <linuxppc-embedded@ozlabs.org>; Mon, 21 Mar 2005 13:55:03 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j2LDt3Qv216128
	for <linuxppc-embedded@ozlabs.org>; Mon, 21 Mar 2005 14:55:03 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id
	j2LDt3C3002285
	for <linuxppc-embedded@ozlabs.org>; Mon, 21 Mar 2005 14:55:03 +0100
In-Reply-To: <Pine.LNX.4.61.0503111609001.9384@blarg.somerset.sps.mot.com>
References: <Pine.LNX.4.61.0503111609001.9384@blarg.somerset.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Message-Id: <43b769d454b49bc3f33414912c7fa3ab@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Sat, 19 Mar 2005 15:36:00 +0100
To: Kumar Gala <galak@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: emulate load/store string instructions
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> +	/* Early out if we are an invalid form of lswi */
> +	if ((instword & INST_STRING_MASK) == INST_LSWX)

Typo --------------------------------------------^


Segher
