Return-Path: <brking@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 38E0767DF8
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 02:08:41 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAAF8a6a024444
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 10:08:39 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAAF8Nfg181192
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 10:08:30 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAAF8M9i025107
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 10:08:23 -0500
Message-ID: <455495B7.4050701@us.ibm.com>
Date: Fri, 10 Nov 2006 09:07:35 -0600
From: Brian King <brking@us.ibm.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: ipr SATA support is causing problems
References: <17748.25705.543922.486456@cargo.ozlabs.ibm.com>	
	<1163159326.19697.23.camel@crusty.rchland.ibm.com>	
	<17748.27504.715056.565983@cargo.ozlabs.ibm.com>
	<1163164499.4168.3.camel@zod.rchland.ibm.com>
In-Reply-To: <1163164499.4168.3.camel@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: akpm@osdl.org, James Bottomley <jejb@mulgrave.il.steeleye.com>,
	John H Rose <johnrose@us.ibm.com>, linuxppc-dev@ozlabs.org,
	torvalds@osdl.org, Paul Mackerras <paulus@samba.org>,
	Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Fri, 2006-11-10 at 23:07 +1100, Paul Mackerras wrote:
>> Josh Boyer writes:
>>
>>> John Rose reported this a few days ago.  Brian responded with this:
>>>
>>> http://marc.theaimsgroup.com/?l=linux-ide&m=116169938407596&w=2
>> Didn't John say he still saw the crash with that change?
> 
> He did on my suggestion, which technically wasn't correct.  I haven't
> seen anything from him after Brian replied with a real patch.
> 
> I know I helped debug a crash that looked very much like that on a P5
> box with a 2.6.19-rcX kernel and Brian's patch fixed it.

Paul,

The backtrace you posted is identical to the problem fixed by the patch
that Josh pointed you to. The patch has been submitted to Jeff. I asked
Jeff two days ago if this could be pulled in for 2.6.19. I verified the
bug and the fix on my machine. As far as I know, John still has not tried
the actual patch pointed to above. Just to clarify, without this patch,
any monolithic kernel will not work on pseries, but modular kernels will
still work. If someone can reproduce any problem with the libata patch
above applied, please let me know.

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
