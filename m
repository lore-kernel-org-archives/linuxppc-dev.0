Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C40391A0790
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 19:22:04 +1000 (AEST)
In-Reply-To: <1441361052-3319-1-git-send-email-bharata.rao@gmail.com>
To: Bharata B Rao <bharata.rao@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: Re: [FIX] powerpc/pseries: Release DRC when configure_connector fails
Message-Id: <20150907092204.AF166140281@ozlabs.org>
Date: Mon,  7 Sep 2015 19:22:04 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-09 at 10:04:12 UTC, Bharata B Rao wrote:
> From: Bharata B Rao <bharata@linux.vnet.ibm.com>
> 
> dlpar_cpu_probe() should release the acquired DRC if configure_connector
> call fails.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Which commit caused this to be a bug? Or has it always been there?

What is the symptom, is it catastrophic, or just cosmetic?

Should the fix go to stable?

cheers
