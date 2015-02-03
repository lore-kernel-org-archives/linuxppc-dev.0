Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0148.outbound.protection.outlook.com [65.55.169.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2149A1A0A7C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 04:17:59 +1100 (AEDT)
Message-ID: <1422983857.12631.2.camel@aoeu.buserror.net>
Subject: Re: [PATCH v3 00/11] powerpc8xx: Further optimisation of TLB handling
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Tue, 3 Feb 2015 11:17:37 -0600
In-Reply-To: <20150203113816.B4B991A5F12@localhost.localdomain>
References: <20150203113816.B4B991A5F12@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-03 at 12:38 +0100, Christophe Leroy wrote:
> This patchset provides a further optimisation of TLB handling in the 8xx.
> Main changes are based on:
> - Using processor handling of PGD/PTE Validity bits instead of testing ourselves
> the entries validity
> - Aligning PGD address to allow direct bit manipulation
> - Not saving registers like CR when not needed
> 
> It also adds support to any TASK_SIZE

Please respin with just the changes that haven't already been applied to
my next branch.

-Scott
