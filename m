Return-Path: <santosh.shilimkar@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BBD622C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 00:51:23 +1000 (EST)
Message-ID: <51ED469A.9000801@ti.com>
Date: Mon, 22 Jul 2013 10:50:02 -0400
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v2] of: Specify initrd location using 64-bit
References: <1372702835-5333-1-git-send-email-santosh.shilimkar@ti.com>
 <51D1F5E2.6070609@gmail.com> <20130720053945.C7AC63E0C52@localhost>
In-Reply-To: <20130720053945.C7AC63E0C52@localhost>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips@linux-mips.org,
 Aurelien Jacquiot <a-jacquiot@ti.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Jonas Bonn <jonas@southpole.se>,
 Russell King <linux@arm.linux.org.uk>, linux-c6x-dev@linux-c6x.org,
 x86@kernel.org, arm@kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Mark Salter <msalter@redhat.com>, Rob Herring <robherring2@gmail.com>,
 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
 linux-xtensa@linux-xtensa.org, James Hogan <james.hogan@imgtec.com>,
 devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>,
 linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Vineet Gupta <vgupta@synopsys.com>,
 Ralf Baechle <ralf@linux-mips.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday 20 July 2013 01:39 AM, Grant Likely wrote:
> On Mon, 01 Jul 2013 16:34:26 -0500, Rob Herring <robherring2@gmail.com> wrote:
>> On 07/01/2013 01:20 PM, Santosh Shilimkar wrote:
>>> On some PAE architectures, the entire range of physical memory could reside
>>> outside the 32-bit limit.  These systems need the ability to specify the
>>> initrd location using 64-bit numbers.
>>>
>>> This patch globally modifies the early_init_dt_setup_initrd_arch() function to
>>> use 64-bit numbers instead of the current unsigned long.
>>>
>>> There has been quite a bit of debate about whether to use u64 or phys_addr_t.
>>> It was concluded to stick to u64 to be consistent with rest of the device
>>> tree code. As summarized by Geert, "The address to load the initrd is decided
>>> by the bootloader/user and set at that point later in time. The dtb should not
>>> be tied to the kernel you are booting"
>>
>> That was quoting me. Otherwise:
>>
>> Acked-by: Rob Herring <rob.herring@calxeda.com>
>>
>> Unless Grant feels compelled to pick this up for 3.11, I think it has to
>> wait for 3.12.
> 
> Nope, 3.12 is fine. Applied.
> 
Thanks Grant.

Regards,
Santosh
