Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwQ2q6dvfzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 15:13:23 +1000 (AEST)
Date: Thu, 28 Apr 2016 15:13:19 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, aneesh.kumar@linux.vnet.ibm.com,
 linux-mm@kvack.org
Subject: Re: [PATCH] powerpc/mm: Always use STRICT_MM_TYPECHECKS
Message-ID: <20160428051319.GA3591@oak.ozlabs.ibm.com>
References: <1461209879-15044-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461209879-15044-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 21, 2016 at 01:37:59PM +1000, Michael Ellerman wrote:
> Testing done by Paul Mackerras has shown that with a modern compiler
> there is no negative effect on code generation from enabling
> STRICT_MM_TYPECHECKS.
> 
> So remove the option, and always use the strict type definitions.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Paul Mackerras <paulus@ozlabs.org>
