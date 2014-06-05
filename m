Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F05EB1A02A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 16:50:17 +1000 (EST)
Message-ID: <1401951004.3247.114.camel@pasglop>
Subject: Re: [PATCH v8 2/3] powerpc/eeh: EEH support for VFIO PCI device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Thu, 05 Jun 2014 16:50:04 +1000
In-Reply-To: <1401950169-30206-3-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1401950169-30206-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401950169-30206-3-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, agraf@suse.de, kvm-ppc@vger.kernel.org,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-06-05 at 16:36 +1000, Gavin Shan wrote:
> +#define EEH_OPT_GET_PE_ADDR    0       /* Get PE addr  */
> +#define EEH_OPT_GET_PE_MODE    1       /* Get PE mode  */

I assume that's just some leftover from the previous patches :-)

Don't respin just yet, let's see what other comments come in.

Cheers,
Ben.
