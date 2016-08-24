Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sK9DN2mrNzDrK5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 00:48:52 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id g202so1370806pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 07:48:52 -0700 (PDT)
Subject: Re: [RFC/PATCH 1/2] cpuidle: Allow idle-states to be disabled at start
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
References: <cover.1471557381.git.ego@linux.vnet.ibm.com>
 <48afad7788300482c047fc35e70ca8e4bf31a5ac.1471557381.git.ego@linux.vnet.ibm.com>
 <57BDB2D8.4080507@linaro.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>, linux-pm@vger.kernel.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <fe9a9667-cbbb-8fa2-5db0-2edd3220ca7b@gmail.com>
Date: Thu, 25 Aug 2016 00:48:38 +1000
MIME-Version: 1.0
In-Reply-To: <57BDB2D8.4080507@linaro.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 25/08/16 00:44, Daniel Lezcano wrote:
> On 08/19/2016 12:26 AM, Gautham R. Shenoy wrote:
>> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>>
>> Currently all the idle states registered by a cpu-idle driver are
>> enabled by default. This patch adds a mechanism which allows the
>> driver to hint if an idle-state should start in a disabled state. The
>> cpu-idle core will use this hint to appropriately initialize the
>> usage->disable knob of the CPU device idle state.
> 
> Why do you need to do that ?
> 

I think patch 2/2 explains the reason as it uses this infrastructure

Balbir Singh
