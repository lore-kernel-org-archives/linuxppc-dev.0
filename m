Return-Path: <okaya@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406Z3X4RTqzF1yg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 04:51:19 +1100 (AEDT)
Subject: Re: RFC on writel and writel_relaxed
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Oliver <oohall@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <3611eabe-2999-1482-b2b4-6d216bbe4762@codeaurora.org>
 <CAOSf1CFmoK2XSn0=qAtiVEO9t4i-DHGgfieiedDfuO6E3tpkQw@mail.gmail.com>
 <4e5c745a-8b9b-959e-8893-d99cd6032484@codeaurora.org>
 <1521692689.16434.293.camel@kernel.crashing.org>
 <CAOSf1CFv1HHCL3YOVhRn2U=grdNjaQ=A4m3xwxN2Rek1-_TySg@mail.gmail.com>
 <1521726722.16434.312.camel@kernel.crashing.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5ccdb208-4664-0a7f-df5d-2e12cbe4c239@codeaurora.org>
Date: Thu, 22 Mar 2018 12:51:15 -0500
MIME-Version: 1.0
In-Reply-To: <1521726722.16434.312.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/22/2018 8:52 AM, Benjamin Herrenschmidt wrote:
>>> No, it's not sufficient.
> Just to clarify ... barrier() is just a compiler barrier, it means the
> compiler will generate things in the order they are written. This isn't
> sufficient on archs with an OO memory model, where an actual memory
> barrier instruction needs to be emited.

Surprisingly, ARM64 GCC compiler generates a write barrier as
opposed to preventing code reordering.

I was curious if this is an ARM only thing or not. 

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
