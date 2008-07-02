Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C43E9DE69D
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 03:37:47 +1000 (EST)
Message-Id: <61D15FC6-64DC-4342-B16D-4FBFF86099A9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <486BB6E3.1060602@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 1/3] mpc83xx: Power Management support
Date: Wed, 2 Jul 2008 12:37:36 -0500
References: <20080625215051.GA11784@loki.buserror.net>
	<7B906E0F-3149-43F0-815A-8314BF5BA039@kernel.crashing.org>
	<486BB6E3.1060602@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 2, 2008, at 12:12 PM, Scott Wood wrote:

> Kumar Gala wrote:
>>> +#define SS_MEMSAVE    0x00
>> What is this? add a comment?
>
> There's a comment where MEMSAVE is used:
>
>        /* The first 2 words of memory are used to communicate with the

I read this as the memory address 0, 0x4.  do you mean the first two  
words of the save area?
>
>         * bootloader, to tell it how to resume.
>         *
>         * The first word is the magic number 0xf5153ae5, and the  
> second
>         * is the pointer to mpc83xx_deep_resume.
>         *
>         * The original content of these two words is saved in the  
> state
>         * save area.
>         */
>
> We could stick a /* First 8 bytes of RAM */ after the #define if you  
> want.

ahh, might be useful to add SS_MEMSAVE into the comment.

- k
