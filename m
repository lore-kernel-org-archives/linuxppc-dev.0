Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E7AC81A01DC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 20:23:53 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 24 Dec 2015 19:23:51 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E37782BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 20:23:44 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBO9NZBH2293988
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 20:23:44 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBO9NBYX032715
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 20:23:11 +1100
Message-ID: <567BB96D.6050504@linux.vnet.ibm.com>
Date: Thu, 24 Dec 2015 14:52:53 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org,
 benh@kernel.crashing.org, bharata@linux.vnet.ibm.com
CC: lvivier@redhat.com, thuth@redhat.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 0/3] Prototype PAPR hash page table resizing (guest side)
References: <1450761298-12172-1-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1450761298-12172-1-git-send-email-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/22/2015 10:44 AM, David Gibson wrote:
> I've discussed with Paul and Ben previously the possibility of
> extending PAPR to allow changing the size of a running guest's hash
> page table (HPT).  This would allow for much more flexible memory
> hotplug, since the HPT wouldn't have to be sized in advance for the
> maximum possible memory size of the guest.

Does it include reducing the size of HPT as well ?
