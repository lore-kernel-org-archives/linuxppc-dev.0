Return-Path: <benh@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3022B14010D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 10:26:25 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 23 Apr 2014 10:26:23 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5A9532CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 10:26:21 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3N05JdF60752126
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 10:05:19 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3N0QKRo011297
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 10:26:20 +1000
Message-ID: <1398212778.19682.129.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc/powernv: clear the refcount for pci_dev on
 powernv platform
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Wed, 23 Apr 2014 10:26:18 +1000
In-Reply-To: <20140422230033.GA12208@shangw>
References: <1398047119-6861-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140421233423.GA4023@shangw> <20140422074437.GB6431@richard>
 <1398155109.19682.89.camel@pasglop> <20140422230033.GA12208@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@au1.ibm.com, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-04-23 at 09:00 +1000, Gavin Shan wrote:
> The side effect of holding pci_dev refcount is the pci_dev, eeh_dev,
> eeh_pe instance can't be free'ed during fully hotplug though EEH can
> survive. It's reasonable to remove it.

Allright. Can you guys refresh that patch with an updated cset
comment and shoot it upstream ?

Thanks !

Cheers,
Ben.
