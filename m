Return-Path: <trini@kernel.crashing.org>
Date: Fri, 22 Oct 2004 13:10:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
Message-ID: <20041022201052.GB7471@smtp.west.cox.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DB90@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DB90@ismail.innsys.innovsys.com>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 uart early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Oct 21, 2004 at 04:57:56PM -0500, Rune Torgersen wrote:

> Is there any way of getting an early console output on a kernel on an
> 8260? (running u-boot as bootloader)

Yes, A mini-driver to hook into ppc_md.progress would be one method.
Another would be to do what's needed (I don't know off-hand what, sorry)
so that you can register the console much earlier, like the
early_printk.c stuff (see arch/x86_64/kernel/early_printk.c) does.


> BTW..
> What are the device node numbers for ttyCPM[0..5] ?

204 42...45 (devices.txt in linuxppc-2.5, Pantelis ever figure out what
to do about the device # conflict with the i.MX driver so we can push
that small bit upstream ?)

-- 
Tom Rini
http://gate.crashing.org/~trini/
