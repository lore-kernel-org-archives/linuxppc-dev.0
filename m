Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 892DB1400DB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 11:56:46 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 23 Apr 2014 07:26:43 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 3FAE91258044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 07:29:24 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3N1uiHg8258018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 07:26:45 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3N1ucgg012412
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 07:26:38 +0530
Date: Wed, 23 Apr 2014 09:56:36 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/powernv: clear the refcount for pci_dev on
 powernv platform
Message-ID: <20140423015636.GC4811@richard>
References: <1398047119-6861-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140421233423.GA4023@shangw> <20140422074437.GB6431@richard>
 <1398155109.19682.89.camel@pasglop> <20140422230033.GA12208@shangw>
 <1398212778.19682.129.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398212778.19682.129.camel@pasglop>
Cc: aik@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 23, 2014 at 10:26:18AM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2014-04-23 at 09:00 +1000, Gavin Shan wrote:
>> The side effect of holding pci_dev refcount is the pci_dev, eeh_dev,
>> eeh_pe instance can't be free'ed during fully hotplug though EEH can
>> survive. It's reasonable to remove it.
>
>Allright. Can you guys refresh that patch with an updated cset
>comment and shoot it upstream ?

Glad to do so.

>
>Thanks !
>
>Cheers,
>Ben.
>

-- 
Richard Yang
Help you, Help me
