Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 07AF61A0015
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 01:54:18 +1000 (AEST)
Date: Thu, 14 May 2015 17:36:39 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 scottwood@freescale.com
Subject: Re: [PATCH v2 0/2] powerpc/kvm: Enable running guests on RT Linux
Message-ID: <20150514153639.GA13442@linutronix.de>
References: <1429890793-19487-1-git-send-email-bogdan.purcareata@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1429890793-19487-1-git-send-email-bogdan.purcareata@freescale.com>
Cc: b10716@freescale.com, linux-rt-users@vger.kernel.org, agraf@suse.de,
 linux-kernel@vger.kernel.org, mihai.caraman@freescale.com, pbonzini@redhat.com,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Bogdan Purcareata | 2015-04-24 15:53:11 [+0000]:

>0001: converts the openpic spinlock to a raw spinlock, in order to circumvent
>0002: disables in-kernel MPIC emulation for guest running on RT, in order to

Scott, I'm asking here for your explicit Acked-by on those two patches.
That you want it *that* way. We have now a nice explanation in #1 :)

Sebastian
