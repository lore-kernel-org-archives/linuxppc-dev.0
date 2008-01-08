Return-Path: <ahuja@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B6A64DDE48
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 11:50:54 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m080opOq026423
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:50:51 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m080opFa463242
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:50:51 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m080ooOP021191
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:50:51 -0500
Message-ID: <4782C8E9.8040104@austin.ibm.com>
Date: Mon, 07 Jan 2008 18:50:49 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/8] pseries: phyp dump: reserve-release proof-of-concept
References: <4782C1A8.3050804@austin.ibm.com>
	<200801080126.51897.arnd@arndb.de>
In-Reply-To: <200801080126.51897.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	lkessler@us.ibm.com, strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd,

Sorry this patch ended up out of sequence. I reposted it properly again in the other thread.

We did talk about using gmail address, but Linas was more comfortable using this as this is
where he was, when we did this. Hence the use of Austin address with gmail being on the cc list.

I am sure he will chime in with more details about it when he gets the opportunity.

Thanks,
Manish



Arnd Bergmann wrote:
> On Tuesday 08 January 2008, Manish Ahuja wrote:
> 
>> Initial patch for reserving memory in early boot, and freeing it later.
>> If the previous boot had ended with a crash, the reserved memory would contain
>> a copy of the crashed kernel data.
>>
>> Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
>> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> 
> I think the signed-off-by chain needs to be modified. The way it appears,
> you handled the patch first, then sent it to Linas, who forwarded it
> to whoever will take the patches from the list.
> 
> This obviously isn't true, since you are actually the one who is sending
> out the patches. Moreover, I believe that the linas@austin.ibm.com
> address is now dead, and shouldn't be used for this any more.
> 
> So, depending on which of you two wrote the majority of a patch, I think
> it should be either
> 
> | Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
> | Acked-by: Linas Vepstas <linasvepstas@gmail.com>
> 
> or 
> 
> | From: Linas Vepstas <linasvepstas@gmail.com>
> | Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
> 
> 	Arnd <><
