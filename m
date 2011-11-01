Return-Path: <nacc@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 8460AB6F71
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2011 04:33:24 +1100 (EST)
Received: from /spool/local
 by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nacc@us.ibm.com>;
 Tue, 1 Nov 2011 13:26:59 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA1HPYWS228526
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Nov 2011 13:25:34 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA1HPXVJ008196
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Nov 2011 13:25:34 -0400
Date: Tue, 1 Nov 2011 10:25:31 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Ryan Wang <openspace.wang@gmail.com>
Subject: Re: What does rmo/tce stand for in powerpc?
Message-ID: <20111101172531.GG16267@us.ibm.com>
References: <CAPxxNQnhXaKJ5ve-=0qwChuuvDj_027RM2pSD43DEf6BZbaHDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPxxNQnhXaKJ5ve-=0qwChuuvDj_027RM2pSD43DEf6BZbaHDA@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ryan,

On 01.11.2011 [14:25:43 +0800], Ryan Wang wrote:
> Hi,
> 
> In kernel source comments, I saw the words:
> ''
> 
> alloc_top is set to the top of RMO, eventually shrink down if the
> <http://lxr.linux.no/linux+*/arch/powerpc/kernel/prom_init.c#L972>TCEs
> overlap
> 
> ''
> 
> I wonder what does RMO mean, and TCE?

RMO = Real Mode Offset -- deprecated in terms of Real Mode Area in PAPR.

TCE = Translation Control Entry

You should be able to find descriptions of both in PAPR.

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
