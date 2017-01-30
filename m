Return-Path: <rjwysocki@gmail.com>
Received: from mail-ot0-x242.google.com (mail-ot0-x242.google.com
 [IPv6:2607:f8b0:4003:c0f::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBgZ32wkHzDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 18:12:11 +1100 (AEDT)
Received: by mail-ot0-x242.google.com with SMTP id f9so37495282otd.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jan 2017 23:12:11 -0800 (PST)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <871svlxl7w.fsf@concordia.ellerman.id.au>
References: <1485333389-5752-1-git-send-email-ego@linux.vnet.ibm.com>
 <1485333389-5752-4-git-send-email-ego@linux.vnet.ibm.com>
 <871svlxl7w.fsf@concordia.ellerman.id.au>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Jan 2017 08:12:09 +0100
Message-ID: <CAJZ5v0j_vzsaNeYNBmKs3oMnXyVHF_3chRjeTEwQA_k0TDc3Nw@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] cpuidle:powernv: Add helper function to populate
 powernv idle states.
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Oliver O'Halloran" <oohall@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 30, 2017 at 4:47 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
>
>> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>>
>> In the current code for powernv_add_idle_states, there is a lot of code
>> duplication while initializing an idle state in powernv_states table.
>>
>> Add an inline helper function to populate the powernv_states[] table
>> for a given idle state. Invoke this for populating the "Nap",
>> "Fastsleep" and the stop states in powernv_add_idle_states.
>>
>> Acked-by: Balbir Singh <bsingharora@gmail.com>
>> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>> ---
>>  drivers/cpuidle/cpuidle-powernv.c | 89 +++++++++++++++++++++++----------------
>>  include/linux/cpuidle.h           |  1 +
>
> I was going to merge this, but I see you've touched cpuidle.h, so I feel
> like I should get an ACK from the cpuidle folks.
>
> It's a fairly uncontroversial change, but it's their API.

OK, please add an ACK from me to it then.

Thanks,
Rafael
