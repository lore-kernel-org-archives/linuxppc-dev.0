Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 3E3B5B7209
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2011 13:30:28 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Tue, 15 Nov 2011 02:28:46 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAF2UB301646774
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2011 13:30:11 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAF2UBr0008923
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2011 13:30:11 +1100
Message-ID: <4EC1CEAF.3040308@in.ibm.com>
Date: Tue, 15 Nov 2011 08:00:07 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] powerpc/44x: Fix typos '47x' and 'CONFIG_47x'
References: <1321309827.20271.146.camel@x61.thuisdomein>
In-Reply-To: <1321309827.20271.146.camel@x61.thuisdomein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/15/11 04:00, Paul Bolle wrote:
> Commit 674bfa4855 ("powerpc/44x: Kexec support for PPC440X chipsets")
> used the Kconfig symbol '47x', and the macro 'CONFIG_47x'. Neither
> exist. These should have been 'PPC_47x' and 'CONFIG_PPC_47x'. Fix these
> typos.

Thanks for catching this. I have already sent a series which fixes the
same. (Sub: Kdump support for PPC440x ). But I think I missed one hunk in
the misc_32.S.

>
> Also fix a related preprocessor check at the top of kexec.h.
>

Thanks

Suzuki
