Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 0AC87DE283
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 18:41:06 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KJP2t-0006Kh-BH
	for linuxppc-embedded@ozlabs.org; Thu, 17 Jul 2008 01:41:03 -0700
Message-ID: <18504063.post@talk.nabble.com>
Date: Thu, 17 Jul 2008 01:41:03 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to allocate 9MB of memory in kernel ?
In-Reply-To: <d194b8ce0807170102x4be8b7ccx33a6a09e6129a45b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <18503022.post@talk.nabble.com>
	<d194b8ce0807170102x4be8b7ccx33a6a09e6129a45b@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



In have a sdram of size 9MB which i would map to kernel space (ioremap woul=
d
do that ) the whole 9 MB kernel virtual memory i need to map to the
application , the application would read when driver has complited writing
and vice versa this implimentation would be in a circular buffer type. The
size of my RAM is 128 MB=20



Sylvain Joyeau wrote:
>=20
> Misbah,
>=20
> Please, give some more details about your application: the answer(s)
> heavily depends on the kind of memory you want to allocate: contiguous
> (implied in DMA purpose) or not (for process memory sharing only).
>=20
> --
> sj
>=20
>=20
> 2008/7/17 Misbah khan <misbah_khan@engineer.com>:
>>
>> Hi all,
>>
>> I need to allocate 9 MB of memory in to the kernel space which i need to
>> mmap for the application to access.
>>
>> I need to know what could be the best possible way of doing the same.
>>
>> Please share your experience in this regard .
>>
>> Thank you in advance
>>
>> ----Misbah <><
>> --
>> View this message in context:
>> http://www.nabble.com/how-to-allocate-9MB-of-memory-in-kernel---tp185030=
22p18503022.html
>> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>=20
>=20
>=20
> --=20
> ------------------
> Sylvain JOYEAU
> Freelance Engineer
> Software RT-OS R&D
> sylvain.joyeau@gmail.com
> T=C3=A9l: +33-(0)667 477 052
> "A good idea is one side of the coin. The other side is the practical
> usefulness". J. Liedke.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20

--=20
View this message in context: http://www.nabble.com/how-to-allocate-9MB-of-=
memory-in-kernel---tp18503022p18504063.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
