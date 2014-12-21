Return-Path: <whitebox@nefkom.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0A721A0C1A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 01:23:05 +1100 (AEDT)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4876114007D
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Dec 2014 01:23:04 +1100 (AEDT)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: powernv: Return to cpu offline loop when
 finished in KVM guest
References: <20141203034840.GA612@iris.ozlabs.ibm.com>
Date: Sun, 21 Dec 2014 15:13:41 +0100
In-Reply-To: <20141203034840.GA612@iris.ozlabs.ibm.com> (Paul Mackerras's
 message of "Wed, 3 Dec 2014 14:48:40 +1100")
Message-ID: <878ui13xbe.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/kvm/built-in.o: In function `kvm_no_guest':
arch/powerpc/kvm/book3s_hv_rmhandlers.o:(.text+0x724): undefined reference to `power7_wakeup_loss'

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
