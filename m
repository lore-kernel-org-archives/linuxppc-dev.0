Return-Path: <mzaturenskiy.st@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.243])
	by bilbo.ozlabs.org (Postfix) with ESMTP id C906AB7142
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 03:41:18 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id k29so404920rvb.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 01 Jul 2009 10:41:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <97dd5fd20906301048o30354271haf603a9bae29b0fe@mail.gmail.com>
References: <97dd5fd20906260913x351593c9raa429fd657eb42f0@mail.gmail.com>
	<4A4901A8.5010402@mlbassoc.com>
	<97dd5fd20906291113t5ea98285h2db6379ff1a940c@mail.gmail.com>
	<4A490AE4.7000509@freescale.com>
	<97dd5fd20906291324jf085addjaa61ff48dfca3d04@mail.gmail.com>
	<4A49249C.5080101@freescale.com>
	<97dd5fd20906291346s3ee60edbr1863c27280ae373c@mail.gmail.com>
	<4A492C1A.6020302@freescale.com>
	<97dd5fd20906300911k7b1e72banf61bcb9ff500787@mail.gmail.com>
	<97dd5fd20906301048o30354271haf603a9bae29b0fe@mail.gmail.com>
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Wed, 1 Jul 2009 12:40:57 -0500
Message-ID: <97dd5fd20907011040t6d489596va7526ca39cb7c604@mail.gmail.com>
Subject: Re: Trouble "Transferring control to Linux (at address 00000000)"
To: Detlev Zundel <dzu@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> As for my device tree, I reverted back to the original version with
>> nothing filled in and just replaced 0xfa20xxxx with 0xf000xxxx as Gary
>> suggested earlier.
>
>Would it be a problem to also dynamically fixup IMMR in the device tree
>from U-Boot?
>
>Cheers
> Detlev

Hi Detlev, it would be nice but how do I do this?
