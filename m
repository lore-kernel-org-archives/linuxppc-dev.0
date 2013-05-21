Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 5CEC72C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 00:45:02 +1000 (EST)
Date: Tue, 21 May 2013 16:45:49 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] Enable multiple MSI feature in pSeries
Message-ID: <20130521144548.GB21632@dhcp-26-207.brq.redhat.com>
References: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 15, 2013 at 03:38:53PM +0800, Mike Qiu wrote:
> The test results is shown by 'cat /proc/interrups':
>           CPU0       CPU1       CPU2       CPU3       
> 16:     240458     261601     226310     200425      XICS Level     IPI
> 17:          0          0          0          0      XICS Level     RAS_EPOW
> 18:         10          0          3          2      XICS Level     hvc_console
> 19:     122182      28481      28527      28864      XICS Level     ibmvscsi
> 20:        506    7388226        108        118      XICS Level     eth0
> 21:          6          5          5          5      XICS Level     host1-0
> 22:        817        814        816        813      XICS Level     host1-1

Hi Mike,

I am curious if pSeries firmware allows changing affinity masks independently
for multiple MSIs? I.e. in your example, would it be possible to assign IRQ21
and IRQ22 to different CPUs?

Thanks!

> LOC:     398077     316725     231882     203049   Local timer interrupts
> SPU:       1659        919        961        903   Spurious interrupts
> CNT:          0          0          0          0   Performance
> monitoring interrupts
> MCE:          0          0          0          0   Machine check exceptions

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
