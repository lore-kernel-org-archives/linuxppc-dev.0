Return-Path: <jcm@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zG1Zd1ZQRzF0bP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 16:55:21 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 258293DA07
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 05:55:19 +0000 (UTC)
Received: from washington.bos.jonmasters.org (ovpn-121-45.rdu2.redhat.com
 [10.10.121.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B36C35D9CA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 05:55:18 +0000 (UTC)
Subject: Re: [PATCH 07/11] powerpc/64s: Add support for RFI flush of L1-D cache
To: linuxppc-dev@lists.ozlabs.org
References: <20180108165453.26066-1-mpe@ellerman.id.au>
 <20180108165453.26066-7-mpe@ellerman.id.au>
From: Jon Masters <jcm@redhat.com>
Message-ID: <e0a87154-e1b8-49a0-f7c7-4eb161bc8685@redhat.com>
Date: Tue, 9 Jan 2018 00:55:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180108165453.26066-7-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/08/2018 11:54 AM, Michael Ellerman wrote:
> On some CPUs we can prevent the Meltdown vulnerability by flushing the
> L1-D cache on exit from kernel to user mode, and from hypervisor to
> guest.

I've tested multiple iterations of these patches over the past few
weeks, on both real hardware, and on a variety of emulation platforms.

Tested-by: Jon Masters <jcm@redhat.com>

-- 
Computer Architect | Sent from my Fedora powered laptop
