Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D98092C0077
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 19:43:15 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Tue, 24 Sep 2013 19:43:09 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7512F2CE8053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 19:42:56 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8O9Q8Dh30998602
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 19:26:09 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8O9gtDV018244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 19:42:55 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] pci: fix interrupt-map for bridges
In-Reply-To: <1380007334-466-1-git-send-email-aik@ozlabs.ru>
References: <1380007334-466-1-git-send-email-aik@ozlabs.ru>
Date: Tue, 24 Sep 2013 15:12:46 +0530
Message-ID: <87ioxqa73d.fsf@abhimanyu.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> The previous scheme always put 0 as a parent slot#. However it is
> not always the case and QEMU's PCI bridge does not support putting
> device at slot#0 as it claims SHPC support for hotplug.
>
> This modifies the interrups map to let the linux guest resolve XICS
> global interrupt number correctly.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Thanks, Will pull this for next build.

Regards
Nikunj

> ---
> Changes:
> v2:
> * removed redundand r-stack push-pop
>
