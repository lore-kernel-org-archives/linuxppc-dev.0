Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0109.outbound.protection.outlook.com [207.46.100.109])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 115C81A0174
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 14:38:04 +1100 (AEDT)
Message-ID: <54530396.1020306@Freescale.com>
Date: Thu, 30 Oct 2014 22:35:50 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/5] powerpc: Remove bootmem allocator
References: <1410956137-4824-1-git-send-email-anton@samba.org>
 <5451D416.7030300@Freescale.com> <1414721739.21815.4.camel@concordia>
In-Reply-To: <1414721739.21815.4.camel@concordia>
Content-Type: text/plain; charset="utf-8"
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

Hello Michael,


On 10/30/2014 09:15 PM, Michael Ellerman wrote:
> On Thu, 2014-10-30 at 01:00 -0500, Emil Medve wrote:
>> On 09/17/2014 07:15 AM, Anton Blanchard wrote:
>>> At the moment we transition from the memblock alloctor to the bootmem
>>> allocator. Gitting rid of the bootmem allocator removes a bunch of
>>> complicated code (most of which I owe the dubious honour of being
>>> responsible for writing).
>>
>> Any idea on how to move these patches forward?
> 
> It's in my test branch and will go into next on Monday.

Thank you


Cheers,
