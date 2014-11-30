Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 316A11A00BC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Dec 2014 09:24:53 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 011981400B7
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2014 09:24:52 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 1 Dec 2014 08:24:50 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1FE013578067
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2014 09:24:48 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAUMOd9x37552182
 for <linuxppc-dev@ozlabs.org>; Mon, 1 Dec 2014 09:24:47 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAUMOFP0016330
 for <linuxppc-dev@ozlabs.org>; Mon, 1 Dec 2014 09:24:15 +1100
Date: Mon, 1 Dec 2014 09:23:50 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [2/3] powerpc/powernv: Replace OPAL_DEASSERT_RESET with
 EEH_RESET_DEACTIVATE
Message-ID: <20141130222350.GA5371@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1416868020-4129-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <20141126040751.3649B14017B@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141126040751.3649B14017B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 26, 2014 at 03:07:51PM +1100, Michael Ellerman wrote:
>On Mon, 2014-24-11 at 22:26:59 UTC, Gavin Shan wrote:
>> The flag passed to ioda_eeh_phb_reset() should be EEH_RESET_DEACTIVATE,
>> which is translated to OPAL_DEASSERT_RESET or something else by the
>> EEH backend accordingly.
>> 
>> The patch replaces OPAL_DEASSERT_RESET with EEH_RESET_DEACTIVATE for
>> ioda_eeh_phb_reset().
>
>What is the symptom? Does it not work at all or is it just a cosmetic issue?
>ie. should I send this to Linus ASAP or can it wait for the next release.
>
>Looks like this went in as 361f2a2a1536 ("powrpc/powernv: Reset PHB in kdump
>kernel") in 3.16. Should it go to stable?
>

It's just a cosmetic issue and please pick it up for next release.

Thanks,
Gavin

>cheers
>
