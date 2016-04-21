Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qr8CQ5KbzzDqcM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 16:36:02 +1000 (AEST)
Message-ID: <1461220562.3245.3.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Always use STRICT_MM_TYPECHECKS
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.vnet.ibm.com,
 linux-mm@kvack.org
Date: Thu, 21 Apr 2016 16:36:02 +1000
In-Reply-To: <571853FA.5080901@gmail.com>
References: <1461209879-15044-1-git-send-email-mpe@ellerman.id.au>
 <571853FA.5080901@gmail.com>
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

On Thu, 2016-04-21 at 14:15 +1000, Balbir Singh wrote:
> 
> On 21/04/16 13:37, Michael Ellerman wrote:

> > Testing done by Paul Mackerras has shown that with a modern compiler
> > there is no negative effect on code generation from enabling
> > STRICT_MM_TYPECHECKS.
> > 
> > So remove the option, and always use the strict type definitions.
> > 
> 
> Should we wait for Aneesh's patches before merging this in.

Preferably not.

I've already rebased his patches on top of this, it's trivial, it's just
removing code.

It also makes some things we might want to do as part of his series easier
(like adding a raw accessor to get the __be64 pmd/pte val).

cheers
