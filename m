Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EE271A0341
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 16:31:13 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 7 Mar 2016 15:31:07 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 942C92CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 16:29:29 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u275TLsC60227652
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 16:29:29 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u275SucB031475
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 16:28:57 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: "michael.neuling" <michael.neuling@au1.ibm.com>,
 manoj <manoj@linux.vnet.ibm.com>, mrochs <mrochs@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v6 00/20] cxl: Add support for powerVM guest
In-reply-to: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Mon, 07 Mar 2016 16:28:31 +1100
Message-Id: <1457328383-sup-8542@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks guys - I'm pretty happy with this series now and am happy for
this to be merged, unless @mpe has any comments.

Cheers,
-Ian
