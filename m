Return-Path: <heiko.carstens@de.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp15.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E25E92C0092
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 20:23:44 +1000 (EST)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <heiko.carstens@de.ibm.com>;
 Mon, 30 Jul 2012 11:23:37 +0100
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6UANBTe2871364
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 11:23:11 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6UAN5VB012494
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 04:23:10 -0600
Date: Mon, 30 Jul 2012 12:23:05 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [RFC PATCH v5 12/19] memory-hotplug: introduce new function
 arch_remove_memory()
Message-ID: <20120730102305.GB3631@osiris.boeblingen.de.ibm.com>
References: <50126B83.3050201@cn.fujitsu.com> <50126E2F.8010301@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50126E2F.8010301@cn.fujitsu.com>
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-acpi@vger.kernel.org, len.brown@intel.com, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 27, 2012 at 06:32:15PM +0800, Wen Congyang wrote:
> We don't call __add_pages() directly in the function add_memory()
> because some other architecture related things need to be done
> before or after calling __add_pages(). So we should introduce
> a new function arch_remove_memory() to revert the things
> done in arch_add_memory().
> 
> Note: the function for s390 is not implemented(I don't know how to
> implement it for s390).

There is no hardware or firmware interface which could trigger a
hot memory remove on s390. So there is nothing that needs to be
implemented.
