Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sft8c1jHNzDsgc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 20:32:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: xinhui <xinhui.pan@linux.vnet.ibm.com>, kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v7 6/6] powerpc: pSeries: Add pv-qspinlock build
 config/make
In-Reply-To: <57E37216.1030505@linux.vnet.ibm.com>
References: <201609191651.3BF51xRa%fengguang.wu@intel.com>
 <57E37216.1030505@linux.vnet.ibm.com>
Date: Thu, 22 Sep 2016 20:31:59 +1000
Message-ID: <87a8f08bts.fsf@concordia.ellerman.id.au>
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

xinhui <xinhui.pan@linux.vnet.ibm.com> writes:

> hi, all
> 	ok, this patch set depends on
> https://patchwork.kernel.org/patch/8953981/ [V4] powerpc: Implement {cmp}xchg for u8 and u16

AKA: https://patchwork.ozlabs.org/patch/615480/

Sorry I saw the discussion on that and thought there'd be a new version.
But now I read the whole thread it looks like it was OK in the end.

I'll try and get it merged.

cheers
