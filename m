Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 13DBF6893D
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jan 2006 09:14:19 +1100 (EST)
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: dtor_core@ameritech.net
In-Reply-To: <d120d5000601131405w4e20e37fna17767624a4ebf6@mail.gmail.com>
References: <20051225212041.GA6094@hansmi.ch>
	<1137022900.5138.66.camel@localhost.localdomain>
	<20060112000830.GB10142@hansmi.ch>
	<200601122312.05210.dtor_core@ameritech.net>
	<1137189319.4854.12.camel@localhost.localdomain>
	<d120d5000601131405w4e20e37fna17767624a4ebf6@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 09:14:04 +1100
Message-Id: <1137190444.4854.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@killerfox.forkbomb.ch, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
	linux-input@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Right, so do we need "no translation, fnkeyfirst and fnkeylast" option
> or just "fnkeyfirst and fnkeyast"?

I think "no translation" should still be around if people want to handle
it entirely from userland no ?

That is:

 - no translation : nothing special is done, Fx sends Fx keycode
regardless of Fn key, Fn key itsef sends a keycode for itself, there is
no emulation of numlock

 - fnkeyfirst / fnkeylast : Either Fx is translated and Fn-Fx is not or
the opposite. Numlock emulation is enabled.

> Huh? You mean 1, right?

Yah, forget it, I was on crack.
