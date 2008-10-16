Return-Path: <mohan@in.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5A5C3DDDF9
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 21:33:23 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id m9GAUIGo015182
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 06:30:18 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9GAXJ7D277404
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 06:33:19 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9GAXJ3s028459
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 06:33:19 -0400
Message-ID: <48F71868.8000507@in.ibm.com>
Date: Thu, 16 Oct 2008 16:03:12 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Support for relocatable kdump kernel
References: <20081012233420.GA6240@in.ibm.com>
	<18674.42140.69339.584403@drongo.ozlabs.ibm.com>
In-Reply-To: <18674.42140.69339.584403@drongo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Mohan Kumar M writes:
> 
>> Support for relocatable kdump kernel
> 
>> @@ -1401,9 +1414,21 @@ _STATIC(__after_prom_start)
>>  	beq	9f			/* have already put us at zero */
>>  	li	r6,0x100		/* Start offset, the first 0x100 */
>>  					/* bytes were copied earlier.	 */
>> -#ifdef CONFIG_RELOCATABLE
>> +
>> +#ifdef CONFIG_CRASH_DUMP
> 
> What tree is this patch against?  No tree that I can find has a line
> saying "#ifdef CONFIG_RELOCATABLE" at that point.  Or is there a
> prerequisite patch that I haven't seen yet?

Hi Paul,

My patch is based on your PATCH 5 of relocatable kernel patchset (which 
demonstrates kernel can be relocatable).

Do I need to resend the patch by generating the diff with your patch5 also?

Regards,
Mohan.
