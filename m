Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B83081A01FF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 13:15:40 +1100 (AEDT)
Message-ID: <1414721739.21815.4.camel@concordia>
Subject: Re: [PATCH 1/5] powerpc: Remove bootmem allocator
From: Michael Ellerman <mpe@ellerman.id.au>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Fri, 31 Oct 2014 13:15:39 +1100
In-Reply-To: <5451D416.7030300@Freescale.com>
References: <1410956137-4824-1-git-send-email-anton@samba.org>
 <5451D416.7030300@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-10-30 at 01:00 -0500, Emil Medve wrote:
> On 09/17/2014 07:15 AM, Anton Blanchard wrote:
> > At the moment we transition from the memblock alloctor to the bootmem
> > allocator. Gitting rid of the bootmem allocator removes a bunch of
> > complicated code (most of which I owe the dubious honour of being
> > responsible for writing).
> 
> Any idea on how to move these patches forward?

It's in my test branch and will go into next on Monday.

cheers
