Return-Path: <rjw@rjwysocki.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTHnk2MQlzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 01:11:54 +1100 (AEDT)
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by ozlabs.org (Postfix) with SMTP id 3qTHnj3cgQz9s5g
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Mar 2016 01:11:52 +1100 (AEDT)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, pc@us.ibm.com,
 shreyas@linux.vnet.ibm.com, anton@samba.org, mikey@neuling.org
Subject: Re: [PATCH] cpufreq: powernv: Define per_cpu chip pointer to optimize
 hot-path
Date: Mon, 21 Mar 2016 15:13:59 +0100
Message-ID: <1527132.IQ7eWgKzaZ@vostro.rjw.lan>
In-Reply-To: <20160321072255.GB1803@vireshk-i7>
References: <1458274308.6622.79.camel@neuling.org>
 <1458313100-27676-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20160321072255.GB1803@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, March 21, 2016 12:52:55 PM Viresh Kumar wrote:
> On 18-03-16, 20:28, Shilpasri G Bhat wrote:
> > From: Michael Neuling <mikey@neuling.org>
> > 
> > "cpufreq: powernv: Remove cpu_to_chip_id() from hot-path" introduced
> 
> If the patch is already committed, you should provide its commit id as well.
> 
> > 'core_to_chip_map' array to cache the chip-id of all cores. Replace
> > this with per_cpu variable that stores the pointer to the chip-array.
> > This removes the linear lookup and provides a neater and simpler
> > solution.
> > 
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> 
> You are sending this patch and you have updated it as well.. So, you should have
> had your signed-off here.

Right.  Plus if you send a patch from anyone else, you should add your
sigh-off to it anyway, even if it hasn't been modified.

So Shilpasri, please resend with your S-o-b and with the ACK from Viresh.

Thanks,
Rafael
