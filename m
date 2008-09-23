Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DA734DDF02
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 15:56:24 +1000 (EST)
Subject: Re: Regarding select() on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200809230746.03234.arnd@arndb.de>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E14C@insardxms01.ap.sony.com>
	<200809230746.03234.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 23 Sep 2008 15:56:01 +1000
Message-Id: <1222149361.12085.101.camel@pasglop>
Mime-Version: 1.0
Cc: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2008-09-23 at 07:46 +0200, Arnd Bergmann wrote:
> I would definitely switch over the ppc32 __NR_newselect implementation
> to sys_select. For __NR_select, there is no correct solution, the three
> options are the current ppc_select, the real sys_select or sys_ni_syscall.
> Each of these is broken in different ways, but in practice it will never
> be called anyway.
> 
> I love archeology.

Any idea when glibc got fixed ?

Ben
