Return-Path: <timur.tabi@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.180])
	by ozlabs.org (Postfix) with ESMTP id 32576DDF32
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 02:43:26 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id o28so1926139ele.3
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 09:43:24 -0700 (PDT)
Message-ID: <ed82fe3e0809180943k3f68fdd4sc75bc9acaa5b9a00@mail.gmail.com>
Date: Thu, 18 Sep 2008 11:43:24 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch
In-Reply-To: <18642.33679.149733.537374@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <18642.33679.149733.537374@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 18, 2008 at 11:36 AM, Paul Mackerras <paulus@samba.org> wrote:
>    powerpc: Fix interrupt values for DMA2 in MPC8610 HPCD device tree
>
>    For Freescale 8xxx devices that use an MPIC, the interrupt numbers in
>    the device tree must be 16 greater than the values documented in the
>    reference manual.  In these chips, the MPIC is wired to use the first
>    16 numbers for external interrupts, but the documentation numbers
>    internal interrupts from 0.
>
>    In the MPC8610 HPCD device tree, the interrupt properties for the DMA
>    channels for DMA2 were not the adjusted values.  This fixes that.

Did you edit this patch when you pulled it from Kumar's repo?  The
commit in Kumar's repo says "This patch fixes that.", which is what I
wrote.  However, in your tree, the word "patch" is missing.

-- 
Timur Tabi
Linux kernel developer at Freescale
