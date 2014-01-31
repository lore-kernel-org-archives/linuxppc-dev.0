Return-Path: <klebers@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8B62F2C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 23:20:18 +1100 (EST)
Received: from /spool/local
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <klebers@linux.vnet.ibm.com>;
 Fri, 31 Jan 2014 10:20:11 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id E78001DC006A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 07:20:07 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0VCJXUs42729550
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 10:19:33 -0200
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0VCK76f022510
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 10:20:07 -0200
Message-ID: <52EB94F6.6000800@linux.vnet.ibm.com>
Date: Fri, 31 Jan 2014 10:20:06 -0200
From: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] Fixes for PCI-E link speed
References: <1389967012-7774-1-git-send-email-klebers@linux.vnet.ibm.com>
In-Reply-To: <1389967012-7774-1-git-send-email-klebers@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Brian King <brking@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/17/2014 11:56 AM, Kleber Sacilotto de Souza wrote:
> These two patches fix problems on the PCI-E link speed detection.
> The first one fixes a regression and adds some improvements on the
> code, and the second one adds definitions for Gen3 speeds.
>
> Kleber Sacilotto de Souza (2):
>    powerpc/pseries: fix regression on PCI link speed
>    powerpc/pseries: add Gen3 definitions for PCIE link speed
>
>   arch/powerpc/platforms/pseries/pci.c |   22 +++++++++++++++-------
>   1 files changed, 15 insertions(+), 7 deletions(-)
>

Hi,

Any feedback on this patch series?


Thanks,

-- 
Kleber Sacilotto de Souza
IBM Linux Technology Center
