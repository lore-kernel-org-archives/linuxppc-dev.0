Return-Path: <Johannes.Thumshirn@men.de>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.147])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2AD361A0064
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 23:21:04 +1100 (AEDT)
Date: Tue, 28 Oct 2014 13:13:44 +0100
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Handling of multiple MSI Vecotrs on Freescale P1022
Message-ID: <20141028121337.GA17986@jtlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I've a question regarding the handling of multiple MSI Vectors on a Freescale
P1022. In arch_setup_msi_irqs (arch/powerpc/kernel/msi.c) there is a comment
that PowerPC doesn't support multiple MSI yet.

What is the reason for this comment and is there anything I can do to enable
multiple MSI IRQs?

Thanks,
	Johannes
