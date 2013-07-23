Return-Path: <michael@ellerman.id.au>
Date: Tue, 23 Jul 2013 23:37:04 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Tiejun Chen <tiejun.chen@windriver.com>
Subject: Re: [v1][PATCH 1/1] powerpc/ppc64: rename SOFT_DISABLE_INTS with
 RECONCILE_IRQ_STATE
Message-ID: <20130723133704.GC31944@concordia>
References: <1373944170-22559-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373944170-22559-1-git-send-email-tiejun.chen@windriver.com>
Cc: scottwood@freescale.com, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 16, 2013 at 11:09:30AM +0800, Tiejun Chen wrote:
> The SOFT_DISABLE_INTS seems an odd name for something that updates the
> software state to be consistent with interrupts being hard disabled, so
> rename SOFT_DISABLE_INTS with RECONCILE_IRQ_STATE to avoid this confusion.

Yes!

I have a similar but unfinished patch locally.

cheers
