Return-Path: <okaya@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405rx90qF5zF1WX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 00:58:21 +1100 (AEDT)
Subject: Re: RFC on writel and writel_relaxed
To: Oliver <oohall@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <3611eabe-2999-1482-b2b4-6d216bbe4762@codeaurora.org>
 <CAOSf1CFmoK2XSn0=qAtiVEO9t4i-DHGgfieiedDfuO6E3tpkQw@mail.gmail.com>
 <4e5c745a-8b9b-959e-8893-d99cd6032484@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <2d2a744a-57b2-ca42-db40-4705df0375db@codeaurora.org>
Date: Wed, 21 Mar 2018 08:58:17 -0500
MIME-Version: 1.0
In-Reply-To: <4e5c745a-8b9b-959e-8893-d99cd6032484@codeaurora.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/21/2018 8:53 AM, Sinan Kaya wrote:
> BTW, I have no idea what compiler barrier does on PPC and if
> 
> wrltel() == compiler barrier() + wrltel_relaxed()
> 
> can be said.

this should have been

writel_relaxed() == compiler barrier() + __raw_writel()



-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
