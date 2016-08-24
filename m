Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com
 [IPv6:2a00:1450:400c:c09::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sK97f621ZzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 00:44:46 +1000 (AEST)
Received: by mail-wm0-x22b.google.com with SMTP id o80so31686350wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 07:44:46 -0700 (PDT)
Subject: Re: [RFC/PATCH 1/2] cpuidle: Allow idle-states to be disabled at start
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
References: <cover.1471557381.git.ego@linux.vnet.ibm.com>
 <48afad7788300482c047fc35e70ca8e4bf31a5ac.1471557381.git.ego@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <57BDB2D8.4080507@linaro.org>
Date: Wed, 24 Aug 2016 16:44:40 +0200
MIME-Version: 1.0
In-Reply-To: <48afad7788300482c047fc35e70ca8e4bf31a5ac.1471557381.git.ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/19/2016 12:26 AM, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Currently all the idle states registered by a cpu-idle driver are
> enabled by default. This patch adds a mechanism which allows the
> driver to hint if an idle-state should start in a disabled state. The
> cpu-idle core will use this hint to appropriately initialize the
> usage->disable knob of the CPU device idle state.

Why do you need to do that ?

> The state can be enabled at run time by echo'ing a zero to the sysfs
> "disable" control file.

... for each cpu.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
