Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EE7D8688D9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Dec 2005 21:18:05 +1100 (EST)
Message-ID: <43ABCED6.2030008@varma-el.com>
Date: Fri, 23 Dec 2005 13:17:58 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Pantelis Antoniou <panto@intracom.gr>
References: <43A98F90.9010001@varma-el.com> <yq0d5jpuoqe.fsf@jaguar.mkp.net>
	<43AAEE12.5030009@varma-el.com>
	<200512222033.40156.pantelis.antoniou@gmail.com>
	<43ABA972.4080701@varma-el.com> <43ABAB69.4060703@intracom.gr>
In-Reply-To: <43ABAB69.4060703@intracom.gr>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@trained-monkey.org>,
	linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] genalloc != generic DEVICE memory allocator
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Pantelis Antoniou wrote:
>>
> 
> [snip]
> 
>>
>> Agree, I couldn't see nothing better for a basement of generic dev.
>> alloc.
>>
>> So, it will be much better if it will be moved to lib/.
>>
>> Anyone have some more comments about subj. ?
>>
> 
> Sure, but the call has to be made be a core developer.
> 
> Andrew?

Pantelis, what did you think about renaming rheap.c and rh_xxx, to
something like dev_xxx, since, for example, rh_alloc overlapped with
__rh_alloc (__RegionHach__alloc) in the drivers/md/dm-raid1.c.


-- 
Regards
Andrey Volkov
