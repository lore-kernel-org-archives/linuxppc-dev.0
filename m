Return-Path: <tony.luck@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by ozlabs.org (Postfix) with ESMTP id A7C9FDE1E3
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 09:08:00 +1000 (EST)
From: "Luck, Tony" <tony.luck@intel.com>
To: "benh@kernel.crashing.org" <benh@kernel.crashing.org>, James Bottomley
	<James.Bottomley@HansenPartnership.com>
Date: Thu, 4 Sep 2008 16:07:45 -0700
Subject: RE: [PATCH] Correct printk %pF to work on all architectures
Message-ID: <57C9024A16AD2D4C97DC78E552063EA30A0DC383@orsmsx505.amr.corp.intel.com>
References: <1220473137.3254.29.camel@localhost.localdomain>
	<alpine.LFD.1.10.0809031419560.3515@nehalem.linux-foundation.org>
	<1220481754.3254.42.camel@localhost.localdomain>
	<alpine.LFD.1.10.0809031546310.3515@nehalem.linux-foundation.org>
	<1220482853.3254.47.camel@localhost.localdomain>
	<alpine.LFD.1.10.0809031602270.3515@nehalem.linux-foundation.org>
	<1220484812.3254.59.camel@localhost.localdomain>
	<alpine.LFD.1.10.0809031636320.3515@nehalem.linux-foundation.org>
	<1220492616.3254.64.camel@localhost.localdomain>
	<1220567811.4879.85.camel@pasglop>
In-Reply-To: <1220567811.4879.85.camel@pasglop>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Parisc List <linux-parisc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Make dereference_function_descriptor() more accommodating by allowing
>> architecture overrides.  I put the three overrides (for parisc64, ppc64
>> and ia64) in arch/kernel/module.c because that's where the kernel
>> internal linker which knows how to deal with function descriptors sits.
>>
>> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

ia64 bits still build, boot and work too.

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony
