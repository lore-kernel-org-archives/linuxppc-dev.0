Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LH5f2sxlzF2Pb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 05:18:46 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3AJAeAL087425
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 15:18:43 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h90f2frtr-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 15:18:43 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Tue, 10 Apr 2018 13:18:41 -0600
Subject: Re: [PATCH v3] powerpc/64: Fix section mismatch warnings for early
 boot symbols
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, jeyu@kernel.org, jeyu@redhat.com,
 akpm@linux-foundation.org, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org
References: <1522943439-26235-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <87lgdvbwp8.fsf@concordia.ellerman.id.au>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Tue, 10 Apr 2018 16:18:35 -0300
MIME-Version: 1.0
In-Reply-To: <87lgdvbwp8.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <27349037-9412-ae77-7419-a273e54a909d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/09/2018 11:51 PM, Michael Ellerman wrote:
> Thanks for picking this one up.
> 
> I hate to be a pain ... but before we merge this and proliferate these
> names, I'd like to change the names of some of these early asm
> functions. They're terribly named due to historical reasons.

Indeed :) No worries.

> I haven't actually thought of good names yet though:)
> 
> I'll try and come up with some and post a patch doing the renames.

Alright. Could you please copy me on that, and I can post an update.

cheers,
Mauricio
