Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 91AC6DE024
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Mar 2007 02:05:25 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l2NF5JsZ014885
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 08:05:19 -0700 (MST)
Date: Fri, 23 Mar 2007 10:05:17 -0500
From: Scott Wood <scottwood@freescale.com>
To: jdl@freescale.com, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Remove bogus errors from check_chosen.
Message-ID: <20070323150517.GB6060@ld0162-tx32.am.freescale.net>
References: <20070322161109.GA20512@ld0162-tx32.am.freescale.net>
	<20070323033158.GG28006@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070323033158.GG28006@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 23, 2007 at 02:31:58PM +1100, David Gibson wrote:
> I'm not 100% comfortable with this patch; I'd like for dtc to have the
> facility to do more-or-less complete tree validation.

That'd be nice as long as it's optional; it should be possible to do a
low level dts->dtb transformation without the tool assuming that the
output is intended to be a final, valid tree with the specific bindings
that dtc knowns about (or even an OF-ish tree at all).

-Scott
