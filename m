Return-Path: <glikely@secretlab.ca>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E1D482C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jul 2013 22:22:46 +1000 (EST)
Received: by mail-wg0-f43.google.com with SMTP id z11so4573663wgg.34
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jul 2013 05:22:42 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v2] of: Specify initrd location using 64-bit
To: Rob Herring <robherring2@gmail.com>,
 Santosh Shilimkar <santosh.shilimkar@ti.com>
In-Reply-To: <51D1F5E2.6070609@gmail.com>
References: <1372702835-5333-1-git-send-email-santosh.shilimkar@ti.com>
 <51D1F5E2.6070609@gmail.com>
Date: Sat, 20 Jul 2013 06:39:45 +0100
Message-Id: <20130720053945.C7AC63E0C52@localhost>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips@linux-mips.org,
 Aurelien Jacquiot <a-jacquiot@ti.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Jonas Bonn <jonas@southpole.se>,
 Russell King <linux@arm.linux.org.uk>, linux-c6x-dev@linux-c6x.org,
 x86@kernel.org, arm@kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Mark Salter <msalter@redhat.com>,
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

On Mon, 01 Jul 2013 16:34:26 -0500, Rob Herring <robherring2@gmail.com> wrote:
> On 07/01/2013 01:20 PM, Santosh Shilimkar wrote:
> > On some PAE architectures, the entire range of physical memory could reside
> > outside the 32-bit limit.  These systems need the ability to specify the
> > initrd location using 64-bit numbers.
> > 
> > This patch globally modifies the early_init_dt_setup_initrd_arch() function to
> > use 64-bit numbers instead of the current unsigned long.
> > 
> > There has been quite a bit of debate about whether to use u64 or phys_addr_t.
> > It was concluded to stick to u64 to be consistent with rest of the device
> > tree code. As summarized by Geert, "The address to load the initrd is decided
> > by the bootloader/user and set at that point later in time. The dtb should not
> > be tied to the kernel you are booting"
> 
> That was quoting me. Otherwise:
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
> Unless Grant feels compelled to pick this up for 3.11, I think it has to
> wait for 3.12.

Nope, 3.12 is fine. Applied.

g.
