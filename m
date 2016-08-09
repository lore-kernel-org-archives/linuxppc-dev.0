Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7rkH2S4DzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 20:53:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] cxl: Set psl_fir_cntl to production environment value
In-Reply-To: <1470650268-25085-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1470650268-25085-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Tue, 09 Aug 2016 20:53:57 +1000
Message-ID: <87ziomtdq2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> Switch the setting of psl_fir_cntl from debug to production
> environment recommended value. It mostly affects the PSL behavior when
> an error is raised in psl_fir1/2.
>
> Tested with cxlflash.

Is this a fix you want in rc1, or something for 4.9 ?

cheers
