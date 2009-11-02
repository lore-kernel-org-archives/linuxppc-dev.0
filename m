Return-Path: <nfont@austin.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18D191007D2
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 03:14:32 +1100 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA2CAt0s027918
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Nov 2009 07:10:55 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA2GESaT077448
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Nov 2009 11:14:28 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA2GERTM027608
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Nov 2009 11:14:27 -0500
Message-ID: <4AEF0562.3020208@austin.ibm.com>
Date: Mon, 02 Nov 2009 10:14:26 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/6 v5] Memory probe/release files
References: <4AE8ADCF.6090104@austin.ibm.com>	
	<4AE8AFDD.6030504@austin.ibm.com>
	<1256786013.26770.40.camel@pasglop>
In-Reply-To: <1256786013.26770.40.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2009-10-28 at 15:55 -0500, Nathan Fontenot wrote:
>> This patch creates the release sysfs file for memory and updates the
>> exisiting probe file so both make arch-specific callouts to handle removing
>> and adding memory to the system.  This also creates the powerpc specific stubs
>> for handling the arch callouts.
>>
>> The creation and use of these files are governed by the exisitng
>> CONFIG_ARCH_MEMORY_PROBE and new CONFIG_ARCH_MEMORY_RELEASE config options.
>>
>> Signed-off-by: Nathan Fontenot <nfont at austin.ibm.com>
>> ---
> 
> Is there anybody on linux-mm who needs to Ack this patche ?

Not sure.  I will cc linux-mm on the next set of updated patches I send out.

-Nathan

> 
> Cheers,
> Ben.
> 
> 
> 
