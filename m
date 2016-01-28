Return-Path: <ego@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C797C1A030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 19:34:47 +1100 (AEDT)
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CC7AD140BCC
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 19:34:46 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 28 Jan 2016 01:34:44 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E7BC219D803E
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 01:22:42 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0S8YgCt29687984
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 01:34:42 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0S8YfLe002337
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 01:34:42 -0700
Date: Thu, 28 Jan 2016 14:04:36 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com,
 bsingharora@gmail.com, mpe@ellerman.id.au, linux-api@vger.kernel.org
Subject: Re: [PATCH v7 6/6] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
Message-ID: <20160128083436.GD13654@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453965941-7363-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453965941-7363-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shilpa,

A minor nit.
On Thu, Jan 28, 2016 at 12:55:41PM +0530, Shilpasri G Bhat wrote:

[..snip..]
> +
> +What:		/sys/devices/system/cpu/cpufreq/chip*/throttle_reasons/<reason_attributes>
> +Date:		Jan 2016
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +		Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Description:	CPU Frequency throttle reason stat for the chip
> +
> +		This directory contains throttle reason files. Each file gives
> +		the total number of times the max frequency is throttled, except
> +		for 'unthrottle_count', which gives the total number of times
> +		the max frequency is unthrottled after being throttled. Below
> +		are the reason attributes.
> +
> +		cpu_over_temperature: Throttled due to cpu over temperature
> +
> +		occ_reset: Throttled due to reset of OCC
> +
> +		over_current: Throttled due to over current

Overcurrent is a single word. No need of the extra space. You could
fix that and add my Reviewed-by.

--
Thanks and Regards
gautham.
