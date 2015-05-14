Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0104.outbound.protection.outlook.com [207.46.100.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3FAB91A0015
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 03:52:09 +1000 (AEST)
Message-ID: <1431625901.3868.165.camel@freescale.com>
Subject: Re: [PATCH v2 0/2] powerpc/kvm: Enable running guests on RT Linux
From: Scott Wood <scottwood@freescale.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Thu, 14 May 2015 12:51:41 -0500
In-Reply-To: <20150514153639.GA13442@linutronix.de>
References: <1429890793-19487-1-git-send-email-bogdan.purcareata@freescale.com>
 <20150514153639.GA13442@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: b10716@freescale.com, linux-rt-users@vger.kernel.org, agraf@suse.de,
 linux-kernel@vger.kernel.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 mihai.caraman@freescale.com, pbonzini@redhat.com, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-05-14 at 17:36 +0200, Sebastian Andrzej Siewior wrote:
> * Bogdan Purcareata | 2015-04-24 15:53:11 [+0000]:
> 
> >0001: converts the openpic spinlock to a raw spinlock, in order to circumvent
> >0002: disables in-kernel MPIC emulation for guest running on RT, in order to
> 
> Scott, I'm asking here for your explicit Acked-by on those two patches.
> That you want it *that* way. We have now a nice explanation in #1 :)

ACK patch 2 only.  Patch 1 is unnecessary as long as we have patch 2,
and the most likely long-term solutions do not involve converting all
the locking in that file to a raw lock.

-Scott
