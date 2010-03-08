Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 376C1B7CF0
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 01:19:24 +1100 (EST)
Date: Mon, 8 Mar 2010 15:19:12 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: mpc512x uart: testers wanted
Message-ID: <20100308151912.14847a74@wker>
In-Reply-To: <fa686aa41003071645x70dff5d7s89db66416bcc4a0d@mail.gmail.com>
References: <1267978529.2306.0@antares>
	<fa686aa41003071645x70dff5d7s89db66416bcc4a0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Albrecht =?UTF-8?B?RHJlw58=?= <albrecht.dress@arcor.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant, Albrecht,

On Sun, 7 Mar 2010 17:45:23 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> Anatolij, could you please look into this?

I'll look into this tomorrow, need to finish USB support now.
Unfortunately the patch doesn't apply on top of Linus' tree as
patches for reworked MPC5121 PSC UART support have been merged.
Albrecht, could you please rebase your patch?

BTW, the prescaler /16 or /10 was mentioned in the MPC5121e
Preliminary Reference Manual, Rev.0. This seems to be the
reason for the usage of /16 prescaler in the code. Since
newer manuals only mention /32 or /10 prescaler, this should
be corrected/tested. I'll test it later.

Thanks,
Anatolij
