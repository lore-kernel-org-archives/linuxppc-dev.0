Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE1581A0060
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 17:34:18 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 2 Mar 2016 16:34:17 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D74FC3578058
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 17:34:04 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u226Xu7f61145186
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 17:34:04 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u226XWMs020692
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 17:33:32 +1100
Date: Wed, 2 Mar 2016 17:33:06 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 ruscur@russell.cc
Subject: Re: [PATCH v2 0/3] powerpc/eeh: Enhancement to EEH for VF
Message-ID: <20160302063306.GA7710@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1456885732-23070-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1456887816.24490.6.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456887816.24490.6.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 02, 2016 at 02:03:36PM +1100, Michael Ellerman wrote:
>On Wed, 2016-03-02 at 13:28 +1100, Gavin Shan wrote:
>
>> Those patches are based on the series of patches supporting EEH for VF,
>> which is pending for merging: https://patchwork.ozlabs.org/patch/581315/
>
>I haven't merged them yet, so can you please fold the fixes into the series
>where appropriate.
>

Sure, I'll post a new series to include all of them.

Thanks,
Gavin

>cheers
>
