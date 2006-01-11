Return-Path: <dmitry.torokhov@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.193])
	by ozlabs.org (Postfix) with ESMTP id 96EEA681B4
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 08:07:39 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id s1so273777nze
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 13:07:38 -0800 (PST)
Message-ID: <d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
Date: Wed, 11 Jan 2006 16:07:37 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1135575997.14160.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051225212041.GA6094@hansmi.ch>
	<200512252304.32830.dtor_core@ameritech.net>
	<1135575997.14160.4.camel@localhost.localdomain>
Cc: linux-kernel@killerfox.forkbomb.ch, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
	linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
Reply-To: dtor_core@ameritech.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/26/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Sun, 2005-12-25 at 23:04 -0500, Dmitry Torokhov wrote:
>
> > As far as the hook itself - i have that feeling that it should not be
> > done in kernel but via a keymap.
>
> While I understand your feeling, it's a bit annoying in this specific
> case because previous models did this in hardware and all mac keymaps
> already account for that. Knowing how nasty it has been to get mac
> keymaps updated and in a good shape, and to get distros to properly get
> them, it makes a lot of sense to have this small hook in the kernel that
> makes the USB keyboard behave exactly like the older ADB couterparts.
>

Ok, I am looking at the patch again, and I have a question - do we
really need these 3 module parameters? If the goal is to be compatible
with older keyboards then shouldn't we stick to one behavior?

--
Dmitry
