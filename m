Return-Path: <ahuja@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D5DF3DDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 18:16:32 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1F7GSGq007343
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 02:16:28 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1F7GRw5248754
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 02:16:28 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1F7GRkl030867
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 02:16:27 -0500
Message-ID: <47B53C40.10808@austin.ibm.com>
Date: Fri, 15 Feb 2008 01:16:16 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/8] pseries: phyp dump: reserve-release	proof-of-concept
References: <47B13D2E.1070001@austin.ibm.com> <47B145E9.9020907@austin.ibm.com>
	<20080214034621.GA6887@bakeyournoodle.com>
	<20080214231200.GA15724@lixom.net>
In-Reply-To: <20080214231200.GA15724@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Olof,

I will run it through checkpatch before resubmitting.

Thanks,
Manish



Olof Johansson wrote:
> On Thu, Feb 14, 2008 at 02:46:21PM +1100, Tony Breeds wrote:
> 
>> Hi Manish,
>> 	Sorry for the minor nits but this should be:
>>
>> ---
>>  * Linas Vepstas, Manish Ahuja 2008
>>  * Copyright 2008 IBM Corp.
>> ---
>>
>> You can optionally use the '??' symbol after word 'Copyright' but you
>> shouldn't use '(c)' anymore.
>>
>> Also in at least one place you've misspelt "Copyright"
> 
> If we're going to nitpick, then I'd like to point out that the whole
> series needs to be run through checkpatch and at least the whitespace
> issues should be taken care of.
> 
> I'm still not convinced that this is a useful feature compared to
> hardening kdump, especially now that ehea can handle kexec/kdump (patch
> posted the other day). But in the end it's up to Paul if he wants to
> take it or not, not me.
> 
> 
> -Olof
