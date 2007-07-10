Return-Path: <ahuja@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1FADCDDECA
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 04:40:02 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6AHaF7M018068
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 13:36:15 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6AIdwiW521424
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 14:39:58 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6AIdw6f013767
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 14:39:58 -0400
Message-ID: <4693D27D.7070504@austin.ibm.com>
Date: Tue, 10 Jul 2007 13:39:57 -0500
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Infinite loop/always true check possible with unsigned
	counter.
References: <469270F3.4070206@austin.ibm.com>	<46928691.2040008@austin.ibm.com>	<18066.53384.449544.952545@cargo.ozlabs.ibm.com>	<je1wfgh9qj.fsf@sykes.suse.de>	<18067.22066.466767.663198@cargo.ozlabs.ibm.com>	<jewsx8fuqk.fsf@sykes.suse.de>
	<18067.23198.856592.39397@cargo.ozlabs.ibm.com>
In-Reply-To: <18067.23198.856592.39397@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Andreas Schwab writes:
>
>   
>>>> ??? There is no rgn->cnt involved in the comparison.
>>>>         
>>> Look further down in lmb_add_region; there is a second for loop that
>>> does
>>>
>>> 	for (i = rgn->cnt-1; i >= 0; i--)
>>>       
>> Which is exactly the one quoted above.  I still don't see your point.
>>     
>
> You're right - my mistake.
>
> Paul.
>   
I presume the patch is good then. Do I need to change anything ?

Thanks,
Manish
