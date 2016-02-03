Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ECB81A0191
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 01:02:06 +1100 (AEDT)
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6DBA3140C48
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Feb 2016 01:02:03 +1100 (AEDT)
Received: by mail-pa0-x22e.google.com with SMTP id uo6so14331465pac.1
 for <linuxppc-dev@ozlabs.org>; Wed, 03 Feb 2016 06:02:03 -0800 (PST)
Date: Wed, 3 Feb 2016 19:31:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com,
 shreyas@linux.vnet.ibm.com, bsingharora@gmail.com, mpe@ellerman.id.au
Subject: Re: [PATCH v8 0/6] cpufreq: powernv: Redesign the presentation of
 throttle notification and solve bug-fixes in the driver
Message-ID: <20160203140157.GF3469@vireshk>
References: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAJZ5v0g28Px=KPa3uCW86w+u35CKkHd7rCrbTfxDjKHmcBuOEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0g28Px=KPa3uCW86w+u35CKkHd7rCrbTfxDjKHmcBuOEQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03-02-16, 14:40, Rafael J. Wysocki wrote:
> It looks like patches [1-5/6] are not objectionable and I can apply
> them without the last one if you want me to.

Looks fine to me.

-- 
viresh
