Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id B8EF967A65
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 02:29:13 +1100 (EST)
In-Reply-To: <43b769d454b49bc3f33414912c7fa3ab@kernel.crashing.org>
References: <43b769d454b49bc3f33414912c7fa3ab@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <34e690a54bb55ad44bb2518e1d7bf4f3@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 21 Mar 2005 09:29:00 -0600
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Kumar Gala <galak@freescale.com>,
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

Thanks, will send a patch to fix that.

- kumar

On Mar 19, 2005, at 8:36 AM, Segher Boessenkool wrote:

>> +	/* Early out if we are an invalid form of lswi */
>> +	if ((instword & INST_STRING_MASK) == INST_LSWX)
>
> Typo --------------------------------------------^
>
>
> Segher
