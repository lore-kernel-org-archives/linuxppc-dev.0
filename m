Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0026D1A1A2B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 11:02:36 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 10:02:36 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A5D272CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 11:02:33 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2402P8253477556
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 11:02:33 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u240209T022636
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 11:02:01 +1100
Date: Fri, 4 Mar 2016 11:01:36 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 ruscur@russell.cc
Subject: Re: [PATCH v2 0/3] powerpc/eeh: Enhancement to EEH for VF
Message-ID: <20160304000136.GB7162@gwshan>
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

A updated series (v5), which includes the base patches and addtional fixes,
was posted: https://patchwork.ozlabs.org/patch/591650/

Thanks,
Gavin
