Return-Path: <nicolas.ferre@atmel.com>
Message-ID: <4F3BC97C.6030203@atmel.com>
Date: Wed, 15 Feb 2012 16:04:28 +0100
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>,
 devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH v3 24/25] irq_domain: remove "hint" when allocating irq
 numbers
References: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
 <1327700179-17454-25-git-send-email-grant.likely@secretlab.ca>
 <4F316848.4060100@atmel.com>
In-Reply-To: <4F316848.4060100@atmel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/07/2012 07:07 PM, Nicolas Ferre :
> On 01/27/2012 10:36 PM, Grant Likely :
>> The 'hint' used to try and line up irq numbers with hw irq numbers is
>> rather a hack and not very useful.  Now that /proc/interrupts also outputs
>> the hwirq number, it is even less useful to keep around the 'hint' heuristic.
>>
>> This patch removes it.
> 
> Grant,
> 
> While trying your patch series in conjunction with Rob one, I do not
> find this patch in your irqdomain/next branch (and a couple of others).
> Can you tell me if this v3 series is available as a git tree?

I am still interested by patch 24-25 of this series but still cannot
find them in your irqdomain/next branch:
Are they also expected to join the 3.4 merge window material?

Bye,
-- 
Nicolas Ferre
