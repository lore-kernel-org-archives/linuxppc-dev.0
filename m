Return-Path: <jeremy.kerr@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD8191A1A35
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 10:40:22 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 881E7140316
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 10:40:22 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <jeremy.kerr@au1.ibm.com>;
 Wed, 22 Jul 2015 10:40:22 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 141DD357804F
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 10:40:20 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6M0eBxS65339488
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 10:40:19 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6M0dl0Z007532
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 10:39:47 +1000
Message-ID: <55AEE639.6060002@au.ibm.com>
Date: Wed, 22 Jul 2015 08:39:21 +0800
From: Jeremy Kerr <jeremy.kerr@au1.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
CC: Ian Munsie <imunsie@au1.ibm.com>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 "sonal.santan" <sonal.santan@xilinx.com>,
 Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Subject: Re: [PATCH] Fix crash due to processing "memory-controller" nodes
 as "memory"
References: <1437380450-25555-1-git-send-email-imunsie@au.ibm.com>	<20150721124554.332dd228@kryten>	<1437447984.30722.3.camel@ellerman.id.au>
 <20150722091844.114ea023@kryten>
In-Reply-To: <20150722091844.114ea023@kryten>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,

> [PATCH] Fix crash due to processing "memory-controller" nodes as "memory"

Looks good to me. If you apply this to your kexec-lite repo, I'll update
op-build to use the new version, and send the merge requests for op-build.

I'd expect we'd have those changes upstream in the next couple of days.
Xilinx folks: how are you consuming op-build? Do you need a new PNOR
image, or are you constructing those yourself?

Regards,


Jeremy
