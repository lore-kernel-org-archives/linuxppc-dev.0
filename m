Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 91FA01A007F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 12:51:09 +1100 (AEDT)
Received: from mail-pf0-x232.google.com (mail-pf0-x232.google.com
 [IPv6:2607:f8b0:400e:c00::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EE298140CC4
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Feb 2016 12:51:08 +1100 (AEDT)
Received: by mail-pf0-x232.google.com with SMTP id w123so26339024pfb.0
 for <linuxppc-dev@ozlabs.org>; Wed, 03 Feb 2016 17:51:07 -0800 (PST)
Date: Thu, 4 Feb 2016 07:21:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org,
 shreyas@linux.vnet.ibm.com, bsingharora@gmail.com,
 mpe@ellerman.id.au, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 6/6] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
Message-ID: <20160204015103.GM3469@vireshk>
References: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1454442102-1229-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20160203082700.GZ31828@vireshk>
 <56B1BD71.2050403@linux.vnet.ibm.com>
 <20160203090357.GA31828@vireshk>
 <20160203120258.GA32294@in.ibm.com> <20160203140600.GG3469@vireshk>
 <56B229C9.4010909@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B229C9.4010909@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03-02-16, 21:54, Shilpasri G Bhat wrote:
> 
> > 
> > And now that you have mentioned that to me, why shouldn't this stats
> > directory be moved to debugfs ? :)
> > 
> > We are never going to perform a store here, isn't it ? And is just for
> > information, nothing more.
> > 
> 
> I would very much like to keep the throttle stats either in cpuX/cpufreq or
> global cpufreq directory as these are populated by the platform cpufreq driver.
> 
> Today we don't have a requirement to a perform a store operation on these files
> but we can have it in the future.

No issues.

-- 
viresh
