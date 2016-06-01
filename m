Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKFlk0gKyzDqZ6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jun 2016 13:12:34 +1000 (AEST)
Message-ID: <1464750753.19731.2.camel@ellerman.id.au>
Subject: Re: [PATCH v4 09/10] cpuidle/powernv: Add support for POWER ISA v3
 idle states
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org, ego@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Lorenzo
 Pieralisi <Lorenzo.Pieralisi@arm.com>
Date: Wed, 01 Jun 2016 13:12:33 +1000
In-Reply-To: <201605311351.u4VDn1i7019941@mx0a-001b2d01.pphosted.com>
References: <1464095714-48772-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1464095714-48772-10-git-send-email-shreyas@linux.vnet.ibm.com>
 <574C4DA4.4050100@linaro.org>
 <201605311351.u4VDn1i7019941@mx0a-001b2d01.pphosted.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-31 at 19:20 +0530, Shreyas B Prabhu wrote:
> On 05/30/2016 07:56 PM, Daniel Lezcano wrote:
> > On 05/24/2016 03:15 PM, Shreyas B. Prabhu wrote:
> > > +        psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
> > > +                    GFP_KERNEL);
> > > +        rc = of_property_read_u64_array(power_mgt,
> > > +            "ibm,cpu-idle-state-psscr", psscr_val, dt_idle_states);
> > 
> > [cc'ed Lorenzo and Rob ]
> > 
> > I don't see the documentation for the binding. Wouldn't make sense to
> > add the value per idle state instead of an index based array ?


The binding *should* be documented here AFAIK:

  https://github.com/open-power/skiboot/blob/master/doc/device-tree/ibm%2Copal/power-mgt.txt

cheers
