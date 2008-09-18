Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 80820DDF20
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 02:52:27 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1128755yxg.39
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 09:52:25 -0700 (PDT)
Date: Thu, 18 Sep 2008 12:51:30 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [git pull] Please pull powerpc.git merge branch
Message-ID: <20080918165130.GB15953@yoda.jdub.homelinux.org>
References: <18642.33679.149733.537374@cargo.ozlabs.ibm.com>
	<ed82fe3e0809180943k3f68fdd4sc75bc9acaa5b9a00@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ed82fe3e0809180943k3f68fdd4sc75bc9acaa5b9a00@mail.gmail.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 18, 2008 at 11:43:24AM -0500, Timur Tabi wrote:
>On Thu, Sep 18, 2008 at 11:36 AM, Paul Mackerras <paulus@samba.org> wrote:
>>    powerpc: Fix interrupt values for DMA2 in MPC8610 HPCD device tree
>>
>>    For Freescale 8xxx devices that use an MPIC, the interrupt numbers in
>>    the device tree must be 16 greater than the values documented in the
>>    reference manual.  In these chips, the MPIC is wired to use the first
>>    16 numbers for external interrupts, but the documentation numbers
>>    internal interrupts from 0.
>>
>>    In the MPC8610 HPCD device tree, the interrupt properties for the DMA
>>    channels for DMA2 were not the adjusted values.  This fixes that.
>
>Did you edit this patch when you pulled it from Kumar's repo?  The
>commit in Kumar's repo says "This patch fixes that.", which is what I
>wrote.  However, in your tree, the word "patch" is missing.

Yes.  He edits them often for various reasons.  In this case, the word
"patch" is arguably incorrect, as it's now a commit.  So my assumption is
that he left off the noun for the "fix" entirely to avoid stuff like that.

josh
