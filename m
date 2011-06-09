Return-Path: <randy.dunlap@oracle.com>
Received: from rcsinet10.oracle.com (rcsinet10.oracle.com [148.87.113.121])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rcsinet10.oracle.com",
	Issuer "VeriSign Class 3 International Server CA - G3" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E581DB6FDC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 05:49:53 +1000 (EST)
Message-ID: <4DF123AA.6070402@oracle.com>
Date: Thu, 09 Jun 2011 12:48:58 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 7/7] [v5] drivers/virt: introduce Freescale hypervisor
	management driver
References: <1307646794-26374-1-git-send-email-timur@freescale.com>
	<20110609124010.6335559e.randy.dunlap@oracle.com>
	<4DF12345.1040409@freescale.com>
In-Reply-To: <4DF12345.1040409@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: arnd@arndb.de, konrad.wilk@oracle.com, kumar.gala@freescale.com,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	akpm@kernel.org, dsaxena@linaro.org,
	linux-console@vger.kernel.org, greg@kroah.com,
	virtualization@lists.linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/09/11 12:47, Timur Tabi wrote:
> Randy Dunlap wrote:
>>>> +enum fsl_hv_ioctl_cmd {
>>>> +	FSL_HV_IOCTL_PARTITION_RESTART = _IOWR(0, 1, struct fsl_hv_ioctl_restart),
>>>> +	FSL_HV_IOCTL_PARTITION_GET_STATUS = _IOWR(0, 2, struct fsl_hv_ioctl_status),
>>>> +	FSL_HV_IOCTL_PARTITION_START = _IOWR(0, 3, struct fsl_hv_ioctl_start),
>>>> +	FSL_HV_IOCTL_PARTITION_STOP = _IOWR(0, 4, struct fsl_hv_ioctl_stop),
>>>> +	FSL_HV_IOCTL_MEMCPY = _IOWR(0, 5, struct fsl_hv_ioctl_memcpy),
>>>> +	FSL_HV_IOCTL_DOORBELL = _IOWR(0, 6, struct fsl_hv_ioctl_doorbell),
>>>> +	FSL_HV_IOCTL_GETPROP = _IOWR(0, 7, struct fsl_hv_ioctl_prop),
>>>> +	FSL_HV_IOCTL_SETPROP = _IOWR(0, 8, struct fsl_hv_ioctl_prop),
>>>> +};
> 
>> Missing an entry in Documentation/ioctl/ioctl-number.txt for 0 (with conflict!).
> 
> If I change it from 0, I'm going to break binary compatibility with our apps.  I
> agree that maybe I shouldn't have picked 0, but considering how many conflicts
> there already are, I wonder what the point is.  Even if I pick a number that is
> currently not listed in the chart, that doesn't mean that it's actually not
> being used, or that it won't conflict in the future.

Yes, I understood that.

> So is it okay to stick with 0, or do I need to pick a new number?

I wasn't suggesting that you change the 0, just note that it has conflicts,
like other ioctls do.


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
