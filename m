Return-Path: <benh@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1083B1400FD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 18:25:17 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 22 Apr 2014 18:25:13 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 796562CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 18:25:11 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3M8OvB36357466
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 18:24:57 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3M8PAgg016965
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 18:25:11 +1000
Message-ID: <1398155109.19682.89.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc/powernv: clear the refcount for pci_dev on
 powernv platform
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Date: Tue, 22 Apr 2014 18:25:09 +1000
In-Reply-To: <20140422074437.GB6431@richard>
References: <1398047119-6861-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140421233423.GA4023@shangw> <20140422074437.GB6431@richard>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-04-22 at 15:44 +0800, Wei Yang wrote:
> So this patch(the 2nd one) doesn't contribute to clear the warning and
> error.
> Only the first patch did it. Please ignore this one.

But is it correct ? It's not right to keep a refcount elevated if we
don't have to.

Gavin, can you get to the bottom of that refcount business ?

Cheers,
Ben.
