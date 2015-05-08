Return-Path: <xerofoify@gmail.com>
Received: from mail-ig0-x235.google.com (mail-ig0-x235.google.com
 [IPv6:2607:f8b0:4001:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DA5F1A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 May 2015 03:16:32 +1000 (AEST)
Received: by igbsb11 with SMTP id sb11so26941911igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2015 10:16:29 -0700 (PDT)
Message-ID: <554CEF6A.9030403@gmail.com>
Date: Fri, 08 May 2015 13:16:26 -0400
From: nick <xerofoify@gmail.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Build Failure with allyesconfig  for PowerPc on latest verison of
 Linus's tree
Content-Type: text/plain; charset=utf-8
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greetings Benjamin,Paul,Michael and others,
I am reporting the below error message:
drivers/built-in.o: In function `.i40e_vc_process_vflr_event':
(.text+0x1ffaea0): relocation truncated to fit: R_PPC64_REL24 (stub) against symbol `._mcount' defined in .text section in arch/powerpc/kernel/entry_64.o
 drivers/built-in.o: In function `.i40e_vc_process_vflr_event':
(.text+0x1ffafa0): relocation truncated to fit: R_PPC64_REL24 (stub) against symbol `.eeh_check_failure' defined in .text section in arch/powerpc/kernel/built-in.o
drivers/built-in.o: In function `.i40e_vc_process_vflr_event':
(.text+0x1ffb120): relocation truncated to fit: R_PPC64_REL24 (stub) against symbol `.eeh_check_failure' defined in .text section in arch/powerpc/kernel/built-in.o
 drivers/built-in.o: In function `.i40e_vc_process_vflr_event':
 (.text+0x1ffb254): relocation truncated to fit: R_PPC64_REL24 (stub) against symbol `.eeh_check_failure' defined in .text section in arch/powerpc/kernel/built-in.o
drivers/built-in.o: In function `.i40e_vc_process_vflr_event':
 (.text+0x1ffb358): relocation truncated to fit: R_PPC64_REL24 (stub) against symbol `_restgpr0_23' defined in .text.save.restore section in arch/powerpc/lib/built-in.o
 drivers/built-in.o: In function `.i40e_ndo_set_vf_mac':
 (.text+0x1ffb360): relocation truncated to fit: R_PPC64_REL24 (stub) against symbol `_savegpr0_24' defined in .text.save.restore section in arch/powerpc/lib/built-in.o
 drivers/built-in.o: In function `.i40e_ndo_set_vf_mac':
 (.text+0x1ffb374): relocation truncated to fit: R_PPC64_REL24 (stub) against symbol `._mcount' defined in .text section in arch/powerpc/kernel/entry_64.o
 drivers/built-in.o: In function `.i40e_ndo_set_vf_mac':
 (.text+0x1ffb6e4): relocation truncated to fit: R_PPC64_REL24 (stub) against symbol `.eeh_check_failure' defined in .text section in arch/powerpc/kernel/built-in.o
 drivers/built-in.o: In function `.i40e_ndo_set_vf_mac':
 (.text+0x1ffb870): relocation truncated to fit: R_PPC64_REL24 (stub) against symbol `.eeh_check_failure' defined in .text section in arch/powerpc/kernel/built-in.o


This causes the build to break and fail on powerpc on the latest version of Linus's tree. Unfortunately my understanding of the powerpc code is rather limited and therefore felt best just to report it. Please let
me known if there is anything else I can do to help solve this outstanding build breakage.
Cheers,
Nick  
