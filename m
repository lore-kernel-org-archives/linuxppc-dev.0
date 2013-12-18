Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0243.outbound.protection.outlook.com [207.46.163.243])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 882DF2C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 10:48:38 +1100 (EST)
Date: Wed, 18 Dec 2013 17:48:25 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Subject: Re: [v3, 3/7] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
Message-ID: <20131218234825.GA6959@home.buserror.net>
References: <1375838315-27797-4-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1375838315-27797-4-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 07, 2013 at 09:18:31AM +0800, Kevin Hao wrote:
> This is based on the codes in the head_44x.S. The difference is that
> the init tlb size we used is 64M. With this patch we can only load the
> kernel at address between memstart_addr ~ memstart_addr + 64M. We will
> fix this restriction in the following patches.

Which following patch fixes the restriction?  With all seven patches
applied, I was still only successful booting within 64M of memstart_addr.

-Scott
