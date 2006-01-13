Return-Path: <dmitry.torokhov@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.199])
	by ozlabs.org (Postfix) with ESMTP id 64E81689D5
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jan 2006 09:25:06 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id n1so770550nzf
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2006 14:25:05 -0800 (PST)
Message-ID: <d120d5000601131425m729e7aa5vc36fce77b09e33c1@mail.gmail.com>
Date: Fri, 13 Jan 2006 17:25:04 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
In-Reply-To: <1137190444.4854.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051225212041.GA6094@hansmi.ch>
	<1137022900.5138.66.camel@localhost.localdomain>
	<20060112000830.GB10142@hansmi.ch>
	<200601122312.05210.dtor_core@ameritech.net>
	<1137189319.4854.12.camel@localhost.localdomain>
	<d120d5000601131405w4e20e37fna17767624a4ebf6@mail.gmail.com>
	<1137190444.4854.21.camel@localhost.localdomain>
Cc: linux-kernel@killerfox.forkbomb.ch, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
	linux-input@atrey.karlin.mff.cuni.cz
Reply-To: dtor_core@ameritech.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/13/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > Right, so do we need "no translation, fnkeyfirst and fnkeylast" option
> > or just "fnkeyfirst and fnkeyast"?
>
> I think "no translation" should still be around if people want to handle
> it entirely from userland no ?
>
> That is:
>
>  - no translation : nothing special is done, Fx sends Fx keycode
> regardless of Fn key, Fn key itsef sends a keycode for itself, there is
> no emulation of numlock
>
>  - fnkeyfirst / fnkeylast : Either Fx is translated and Fn-Fx is not or
> the opposite. Numlock emulation is enabled.

OK then, I will push the patch to Linus.

--
Dmitry
