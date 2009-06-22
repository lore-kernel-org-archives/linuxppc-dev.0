Return-Path: <blackluck@ktk.bme.hu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DB5AFB71A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 19:10:34 +1000 (EST)
Received: from ns02.broadband.hu (bpdcpr01.bpcl.broadband.hu [195.184.181.4])
	by ozlabs.org (Postfix) with ESMTP id 17AEADDDA2
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 19:10:33 +1000 (EST)
Message-ID: <4A3F4A77.6070704@ktk.bme.hu>
Date: Mon, 22 Jun 2009 11:10:15 +0200
From: Laszlo Fekete <blackluck@ktk.bme.hu>
MIME-Version: 1.0
To: debian-powerpc@lists.debian.org
Subject: Re: sym scsi driver problem with 2.6.26 or newer debian kernel on
	p610 (fwd)
References: <Pine.LNX.4.64.0906141105050.4412@axis700.grange>
	<4A38B883.80507@ktk.bme.hu>
In-Reply-To: <4A38B883.80507@ktk.bme.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Reply-To: blackluck@ktk.bme.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello!

Is there any idea for the solution?

Thanks: blackluck

Laszlo Fekete wrote:
> Hello!
>
> I'm sorry about the annoyances, but I'd welcome all ideas, suggestions 
> to see what needs to be done or should be tested for the solution.
>
> Thank you very much!
>
> Guennadi Liakhovetski wrote:
>> Ok, first attempt to forward this to scsi was wrong, as pointed out 
>> by Matthew Wilcox this does indeed look like an interrupt problem - 
>> no interrupts drom SCSI, IDE, keyboar. Might be a known problem, I 
>> guess. In any case, I think, the OP would be grateful for any hints.
>>
>> Thanks
>> Guennadi
>> ---
>> Guennadi Liakhovetski, Ph.D.
>> Freelance Open-Source Software Developer
>> http://www.open-technology.de/
>>
>> ---------- Forwarded message ----------
>> Date: Sat, 13 Jun 2009 16:22:07 +0200
>> From: Laszlo Fekete <blackluck@ktk.bme.hu>
>> To: debian-powerpc@lists.debian.org
>> Subject: sym scsi driver problem with 2.6.26 or newer debian kernel 
>> on p610
>> Resent-Date: Sat, 13 Jun 2009 14:29:55 +0000 (UTC)
>> Resent-From: debian-powerpc@lists.debian.org
>>
>> This is a multi-part message in MIME format.
>> ------------------------------------------------------------------------
>>
>> Hello!
>>
>>
>>
>>
>>
>> Pls help me with sym scsi driver problem.
>>
>>
>>
>> I have Ibm P610 (and tested it on P630 and P640 too), installed debian
>>
>> etch and upgraded to lenny.
>>
>>
>>
>> But with 2.6.26 or newer kernel it's not booting, it's hang on sym scsi
>>
>> bus scan.
>>
>>
>>
>>
>>
>> Whats the problem with it, or how can I fix this?
>>
>>
>>
>>
>>
>> I attach the output from minicom with 2.6.29, 2.6.26, and the working
>>
>> 2.6.24 kernel booting.
>>
>>
>>
>>
>>
>> Thank you very much!
>>
>>
>>   
>
>
