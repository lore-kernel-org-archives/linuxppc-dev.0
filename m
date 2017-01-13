Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v07pB1Hj8zDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 14:46:10 +1100 (AEDT)
Received: by mail-qk0-x243.google.com with SMTP id 11so5487974qkl.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 19:46:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170113034418.GA10844@in.ibm.com>
References: <1484039224-5630-1-git-send-email-ego@linux.vnet.ibm.com>
 <1484039224-5630-3-git-send-email-ego@linux.vnet.ibm.com>
 <20170112094733.GC3006@localhost.localdomain>
 <20170113034418.GA10844@in.ibm.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Fri, 13 Jan 2017 14:46:07 +1100
Message-ID: <CAOSf1CET-A+E1FkS4hOJLQapnih=Sx51U6BdgjqXy--xJ9nytw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] powernv:stop: Uniformly rename power9 to arch300
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 mark.rutland@arm.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 13, 2017 at 2:44 PM, Gautham R Shenoy
<ego@linux.vnet.ibm.com> wrote:
> On Thu, Jan 12, 2017 at 03:17:33PM +0530, Balbir Singh wrote:
>> On Tue, Jan 10, 2017 at 02:37:01PM +0530, Gautham R. Shenoy wrote:
>> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>> >
>> > Balbir pointed out that in idle_book3s.S and powernv/idle.c some
>> > functions and variables had power9 in their names while some others
>> > had arch300.
>> >
>>
>> I would prefer power9 to arch300
>>
>
>
> I don't have a strong preference for arch300 vs power9, will change it
> to power9 if that looks better.

Personally I think we should be as descriptive as possible and use
power_9_arch_300_the_bikeshed_is_red_dammit.

Oliver
