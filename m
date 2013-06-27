Return-Path: <michael@ellerman.id.au>
Date: Fri, 28 Jun 2013 00:26:14 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Runzhen Wang <runzhen@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/2] perf tools: fix a typo of a Power7 event name
Message-ID: <20130627142614.GC13867@concordia>
References: <1372170933-4538-1-git-send-email-runzhen@linux.vnet.ibm.com>
 <1372170933-4538-2-git-send-email-runzhen@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372170933-4538-2-git-send-email-runzhen@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, xiaoguangrong@linux.vnet.ibm.com,
 acme@redhat.com, paulus@samba.org, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 25, 2013 at 10:35:32PM +0800, Runzhen Wang wrote:
> In the Power7 PMU guide:
> https://www.power.org/documentation/commonly-used-metrics-for-performance-analysis/
> PM_BRU_MPRED is referred to as PM_BR_MPRED.
> 
> It fixed the typo by changing the name of the event in kernel
> and documentation accordingly.

This patch fixes the typo by ...

> This patch changes the ABI, there are some reasons I think it's ok:
> 
> - It is relatively new interface, specific to the Power7 platform.
> 
> - No tools that we know of actually use this interface at this point
>  (none are listed near the interface).
> 
> - Users of this interface (eg oprofile users migrating to perf)
>   would be more used to the "PM_BR_MPRED" rather than "PM_BRU_MPRED".
> 
> - These are in the ABI/testing at this point rather than ABI/stable,
>   so hoping we have some wiggle room.
> 
> Signed-off-by: Runzhen Wang <runzhen@linux.vnet.ibm.com>

Acked-by: Michael Ellerman <michael@ellerman.id.au>

cheers
