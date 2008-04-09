Return-Path: <ahuja@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A5597DDFFF
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 04:43:57 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m39IhqEq022823
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Apr 2008 14:43:52 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m39Ihqjo291460
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Apr 2008 14:43:52 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m39Ihqir001831
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Apr 2008 14:43:52 -0400
Message-ID: <47FD0E67.1090802@austin.ibm.com>
Date: Wed, 09 Apr 2008 13:43:51 -0500
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] pseries: phyp dump: Variable size reserve space.
References: <47FAB221.7050406@austin.ibm.com>
	<20080408024352.GA32761@lixom.net>
	<47FCFEEF.6020607@austin.ibm.com> <20080409183032.GA2360@lixom.net>
In-Reply-To: <20080409183032.GA2360@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hmmm,

You are possibly right.

Okay I can check and fix that.

-Manish

Olof Johansson wrote:
>>> That's 512MB, isn't it?
>> My calculations in the example I gave in the last email were wrong.
>>
>> In mentally did 10% instead of 5%. But the premise is same.
>>
>> So assuming 5% of some memory is 400 MB, it rounds it down to 256MB etc.
> 
> But 0x1fffffff is 512MB, not 256MB. So you're rounding it down to a
> multiple of 512MB.
> 
> 
> -Olof
