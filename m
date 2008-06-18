Return-Path: <jschopp@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6100EDDFB0
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 07:28:19 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5ILSFOG006702
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 17:28:15 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5ILSF17238944
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 17:28:15 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5ILSE0T015273
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 17:28:15 -0400
Message-ID: <48597DED.7070005@austin.ibm.com>
Date: Wed, 18 Jun 2008 16:28:13 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/2] Power7 architected entry
References: <20080618201124.GA23828@gamma> <20080618201821.GA23865@gamma>
	<D57C4E4C-55C3-4886-8128-14CAC80EE475@lixom.net>
In-Reply-To: <D57C4E4C-55C3-4886-8128-14CAC80EE475@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
>
> On Jun 18, 2008, at 3:18 PM, jschopp@austin.ibm.com wrote:
>
>> Add an entry for Power7 architected mode and add "(raw)" to Power7 
>> raw mode to
>> distinguish it more clearly.
>>
>> Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
>> ---
>> arch/powerpc/kernel/cputable.c             |   48 
>> +++++++++++++++++++++++++++++
>> arch/powerpc/platforms/pseries/cpu_setup.S |    6 +++
>> include/asm-powerpc/cputable.h             |    9 +++++
>> 3 files changed, 63 insertions(+)
>
> Huh? This patch only changes one file.
>
>
> -Olof
>
The patch is correct, the shortlog is incorrect.  Must not have gotten 
updated from an earlier version, sorry for the confusion.
