Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C5A641A01A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 15:09:10 +1100 (AEDT)
In-Reply-To: <1416868020-4129-3-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [3/3] powerpc/eeh: Fix missed PE#0 on P7IOC
Message-Id: <20141126040910.AE17D14017B@ozlabs.org>
Date: Wed, 26 Nov 2014 15:09:10 +1100 (AEDT)
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-24-11 at 22:27:00 UTC, Gavin Shan wrote:
> PE#0 should be regarded as valid for P7IOC, while it's invalid for
> PHB3. The patch adds flag EEH_VALID_PE_ZERO to differentiate those
> two cases. Without the patch, we possibly see frozen PE#0 state is
> cleared without EEH recovery taken on P7IOC as following kernel logs
> indicate:

This sounds like an urgent fix but I'm not sure.

cheers
