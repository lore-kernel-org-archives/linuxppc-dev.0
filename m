Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBn1b0h3TzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 22:17:55 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Oliver O'Halloran <oohall@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 3/5] cpuidle:powernv: Add helper function to populate
 powernv idle states.
In-Reply-To: <CAJZ5v0j_vzsaNeYNBmKs3oMnXyVHF_3chRjeTEwQA_k0TDc3Nw@mail.gmail.com>
References: <1485333389-5752-1-git-send-email-ego@linux.vnet.ibm.com>
 <1485333389-5752-4-git-send-email-ego@linux.vnet.ibm.com>
 <871svlxl7w.fsf@concordia.ellerman.id.au>
 <CAJZ5v0j_vzsaNeYNBmKs3oMnXyVHF_3chRjeTEwQA_k0TDc3Nw@mail.gmail.com>
Date: Mon, 30 Jan 2017 22:17:50 +1100
Message-ID: <87efzkx0dd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Mon, Jan 30, 2017 at 4:47 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
>>
>>> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>>>
>>> In the current code for powernv_add_idle_states, there is a lot of code
>>> duplication while initializing an idle state in powernv_states table.
>>>
>>> Add an inline helper function to populate the powernv_states[] table
>>> for a given idle state. Invoke this for populating the "Nap",
>>> "Fastsleep" and the stop states in powernv_add_idle_states.
>>>
>>> Acked-by: Balbir Singh <bsingharora@gmail.com>
>>> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>>> ---
>>>  drivers/cpuidle/cpuidle-powernv.c | 89 +++++++++++++++++++++++----------------
>>>  include/linux/cpuidle.h           |  1 +
>>
>> I was going to merge this, but I see you've touched cpuidle.h, so I feel
>> like I should get an ACK from the cpuidle folks.
>>
>> It's a fairly uncontroversial change, but it's their API.
>
> OK, please add an ACK from me to it then.

Thanks.

cheers
