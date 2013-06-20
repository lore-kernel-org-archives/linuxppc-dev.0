Return-Path: <michael@ellerman.id.au>
Message-ID: <1371691282.21846.1.camel@concordia>
Subject: Re: [PATCH 1/2] perf tools: fix a typo of a Power7 event name
From: Michael Ellerman <michael@ellerman.id.au>
To: Runzhen Wang <runzhen@linux.vnet.ibm.com>
Date: Thu, 20 Jun 2013 11:21:22 +1000
In-Reply-To: <1371633326-7696-1-git-send-email-runzhen@linux.vnet.ibm.com>
References: <1371633326-7696-1-git-send-email-runzhen@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: icycoder@gmail.com, linux-kernel@vger.kernel.org,
 xiaoguangrong@linux.vnet.ibm.com, acme@redhat.com, paulus@samba.org,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-06-19 at 17:15 +0800, Runzhen Wang wrote:
> In the Power7 PMU guide:
> https://www.power.org/documentation/commonly-used-metrics-for-performance-analysis/
> PM_BRU_MPRED is referred to as PM_BR_MPRED.
> 
> This patch fix the typo by changing the name of the event in kernel and
> documentation accordingly.
> 
> Signed-off-by: Runzhen Wang <runzhen@linux.vnet.ibm.com>
> ---
>  .../testing/sysfs-bus-event_source-devices-events  |    2 +-
>  arch/powerpc/perf/power7-pmu.c                     |   12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> index 8b25ffb..3c1cc24 100644
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> @@ -29,7 +29,7 @@ Description:	Generic performance monitoring events
>  
>  What: 		/sys/devices/cpu/events/PM_1PLUS_PPC_CMPL
>  		/sys/devices/cpu/events/PM_BRU_FIN
> -		/sys/devices/cpu/events/PM_BRU_MPRED
> +		/sys/devices/cpu/events/PM_BR_MPRED

So you're changing the ABI.

I think that's probably OK, but you at least need to mention _why_ you
think it's OK.

cheers
