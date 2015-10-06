Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21DAD1A0034
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 17:19:03 +1100 (AEDT)
Message-ID: <1444112342.16578.1.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: Fix number of allocated pages in SPA
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>
Cc: imunsie@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Oct 2015 17:19:02 +1100
In-Reply-To: <1443794485-30565-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1443794485-30565-1-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-10-02 at 16:01 +0200, Christophe Lombard wrote:
> This moves the initialisation of the num_procs to before the SPA
> allocation.

Why? What does it fix? I can't tell from the diff or the change log.

cheers
