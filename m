Return-Path: <pantelis.antoniou@gmail.com>
Received: from uproxy.gmail.com (uproxy.gmail.com [66.249.92.195])
	by ozlabs.org (Postfix) with ESMTP id 016CB68914
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Dec 2005 02:59:19 +1100 (EST)
Received: by uproxy.gmail.com with SMTP id h2so99109ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Dec 2005 07:59:17 -0800 (PST)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 22 Dec 2005 18:09:52 +0200
References: <43A98F90.9010001@varma-el.com> <43AAB508.7000007@intracom.gr>
	<43AAC9E8.2060105@varma-el.com>
In-Reply-To: <43AAC9E8.2060105@varma-el.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Message-Id: <200512221809.53360.pantelis.antoniou@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, jes@trained-monkey.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] genalloc != generic DEVICE memory allocator
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>

[snip]

> I'm sure lib/ will be appropriate place. and something like
> "DON'T TRY REINVENT WHEEL, TRY FIX EXISTS" in documentation/ :).
> 
> Now couple word about rheap: I understand why you are use static
> alignment in allocator, but its very specialized for CPM. IMO, align
> must be a param of xx_alloc. For ex: device may demand alignment by
> 8 bytes, which ok until... you are try map this memory to the user
> space (don't shoot at me, remember about framebuffer & co).
>

It is trivial to align to a given alignment in a call. Please search
the archives since this was needed for CPM2 and I've committed a patch.

As for mapping user space, since rheap only deals with addresses and never
touches the memory it's supposed to control, you can do pretty much everything.

I still don't understand what are you trying to do however.

Mind explaining?
 
> -- 
> Regards
> Andrey Volkov
>

Regards

Pantelis
