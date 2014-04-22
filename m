Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 031AB140084
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 19:45:03 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 22 Apr 2014 19:45:02 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D51D33578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 19:45:00 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3M9O8ne57934072
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 19:24:09 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3M9ixbp032295
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 19:44:59 +1000
Date: Tue, 22 Apr 2014 17:44:56 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/powernv: clear the refcount for pci_dev on
 powernv platform
Message-ID: <20140422094456.GA28188@richard>
References: <1398047119-6861-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140421233423.GA4023@shangw> <20140422074437.GB6431@richard>
 <1398155109.19682.89.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398155109.19682.89.camel@pasglop>
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

On Tue, Apr 22, 2014 at 06:25:09PM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2014-04-22 at 15:44 +0800, Wei Yang wrote:
>> So this patch(the 2nd one) doesn't contribute to clear the warning and
>> error.
>> Only the first patch did it. Please ignore this one.
>
>But is it correct ? It's not right to keep a refcount elevated if we
>don't have to.

The code refcount is introduced in commit 184cd4a3(powerpc/powernv: PCI
support for p7IOC under OPAL v2). To me, it looks not necessary.

>
>Gavin, can you get to the bottom of that refcount business ?
>
>Cheers,
>Ben.
>

-- 
Richard Yang
Help you, Help me
