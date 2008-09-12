Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 47972DDDF6
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Sep 2008 02:19:42 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m8CGJWra026034
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 09:19:38 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m8CGJV2V012106
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 11:19:32 -0500 (CDT)
Date: Fri, 12 Sep 2008 11:19:31 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH V2] Pass actual dev ptr to dma_* in ucc and cpm_uart serial
Message-ID: <20080912161930.GA10212@ld0162-tx32.am.freescale.net>
References: <1221234176-14937-1-git-send-email-becky.bruce@freescale.com>
	<ed82fe3e0809120851i72010bc4vfeb74d124b93039@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ed82fe3e0809120851i72010bc4vfeb74d124b93039@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 12, 2008 at 10:51:24AM -0500, Timur Tabi wrote:
> On Fri, Sep 12, 2008 at 10:42 AM, Becky Bruce <becky.bruce@freescale.com> wrote:
> 
> > Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> 
> Acked-By: Timur Tabi <timur@freescale.com>

ACK

> The changelog could be a little beefier, though.  I'm not a fan of
> having the changelog be an extension of the patch title.

Bah, that's how git works.  Otherwise, you get a silly duplicated line in
"git log".

-Scott
