Return-Path: <danielwa@cisco.com>
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
 (using TLSv1.2 with cipher DHE-RSA-SEED-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E27EA1A0191
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 09:11:00 +1100 (AEDT)
To: Kumar Gala <galak@kernel.crashing.org>,
 Grant Likely <grant.likely@linaro.org>, Rob Herring
 <rob.herring@calxeda.com>, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.ozlabs.org,
 "polaris-kernel-dev(mailer list)" <polaris-kernel-dev@cisco.com>
From: Daniel Walker <danielwa@cisco.com>
Subject: Freescale old style SMP
Message-ID: <56B90F34.1060802@cisco.com>
Date: Mon, 8 Feb 2016 13:57:08 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


In this patch,

http://repository.timesys.com/buildsources/k/kernel/kernel-2.6.32/2.6.32-fsl-p1022ds-201003260230.patch

The SMP code is different from what's upstream. It looks like Freescale 
may have changed the way SMP info is passed from the bootloader to the 
kernel.

Unfortunately, Cisco release a product with a bootloader which conforms 
to what's in the patch above. Newer kernels don't initialize smp using 
our bootloader.

I'm wondering if maybe I'm missing something here, and the smp 
initialization is actually the same, or if there's some fall back which 
is compatible? If not, then what's the best way to integrate this old 
method into what's already upstream?

Thanks,

Daniel
