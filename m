Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 566001A01A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 11:46:25 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 6 Aug 2014 11:46:21 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2D2E52CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 11:46:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s761T0b662980158
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 11:29:01 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s761kCSZ007261
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 11:46:12 +1000
Date: Wed, 6 Aug 2014 11:46:03 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Fix IOMMU group lost
Message-ID: <20140806014603.GA4532@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1407227258-17732-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20140805100036.GA7364@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140805100036.GA7364@richard>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 05, 2014 at 06:00:36PM +0800, Wei Yang wrote:
>I didn't manage to test this one PHB3, since some network issue, I can't
>access the machine in Austin.
>
>Will reply after I test this on PHB3.
>

Yep, thanks. By the way, I tested it on P7 box and looks good
for partial/full hotplug cases.

Thanks,
Gavin
