Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 965C4B7B74
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Oct 2009 22:50:49 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n99BhHNr001360
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2009 07:43:17 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n99BokJL222522
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2009 07:50:46 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n99BlLjp016281
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2009 07:47:22 -0400
Date: Fri, 9 Oct 2009 07:50:42 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH][v2] powerpc/4xx: Add 16K FIFO size DTS entries on
	supported platforms
Message-ID: <20091009115042.GC22408@zod.rchland.ibm.com>
References: <1255019609-2033-1-git-send-email-dmitchell@appliedmicro.com>
	<1255054554.2355.28.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1255054554.2355.28.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Dave Mitchell <dmitchell@appliedmicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 09, 2009 at 01:15:54PM +1100, Benjamin Herrenschmidt wrote:
>On Thu, 2009-10-08 at 11:33 -0500, Dave Mitchell wrote:
>> Adding tx/rx-fifo-size-gige to EMAC fields for evaluation kit DTS
>> files where appropriate.
>> 
>> Signed-off-by: Dave Mitchell <dmitchell@appliedmicro.com>
>> Acked-by: Prodyut Hazarika <phazarika@appliedmicro.com>
>> Acked-by: Victor Gallardo <vgallardo@appliedmicro.com>
>> Acked-by: Loc Ho <lho@appliedmicro.com>
>> ---
>>  v1->v2: local date/time was out-of-sync and thus mail was as well
>
>I'll have to wait for the EMAC patch to go in, so ping me if you don't
>see me take that one after that happens.

I have some other DTS changes I'll be making soon.  Mind if I pick it up
in my tree to avoid headaches?  I will, of course, wait until the EMAC
patch is merged.

josh
