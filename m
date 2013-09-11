Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AA4392C015C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 02:50:38 +1000 (EST)
Message-ID: <1378918198.19147.28.camel@smoke>
Subject: Re: [PATCH V3 1/6] powerpc: Free up the IPI message slot of ipi
 call function (PPC_MSG_CALL_FUNC)
From: Geoff Levand <geoff@infradead.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Wed, 11 Sep 2013 09:49:58 -0700
In-Reply-To: <20130911025100.27726.95866.stgit@preeti.in.ibm.com>
References: <20130911024906.27726.4735.stgit@preeti.in.ibm.com>
 <20130911025100.27726.95866.stgit@preeti.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paul.gortmaker@windriver.com, paulus@samba.org, shangw@linux.vnet.ibm.com,
 rjw@sisk.pl, fweisbec@gmail.com, paulmck@linux.vnet.ibm.com, arnd@arndb.de,
 linux-pm@vger.kernel.org, rostedt@goodmis.org, john.stultz@linaro.org,
 tglx@linutronix.de, chenhui.zhao@freescale.com, deepthi@linux.vnet.ibm.com,
 r58472@freescale.com, linux-kernel@vger.kernel.org,
 srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-11 at 08:21 +0530, Preeti U Murthy wrote:
>  arch/powerpc/platforms/ps3/smp.c        |    2 +-

The PS3 part is trivial and looks OK.

Acked-by: Geoff Levand <geoff@infradead.org>
