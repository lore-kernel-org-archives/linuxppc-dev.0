Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8E9B3474DB
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 05:55:34 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAPItFcf019290
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 13:55:15 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAPItUR6160226
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 13:55:30 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAPItTsf004365
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 13:55:30 -0500
Date: Tue, 25 Nov 2008 13:55:19 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: [PATCH/RFC] Add Alternative Log Buffer Support for printk Messages
Message-ID: <20081125135519.038abf23@zod.rchland.ibm.com>
In-Reply-To: <b5e2fc790811251053w507792a1r3673ee2dc7581379@mail.gmail.com>
References: <1227638045-12862-1-git-send-email-gerickson@nuovations.com>
	<b5e2fc790811251053w507792a1r3673ee2dc7581379@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-embedded@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, Wolfgang Denx <wd@denx.de>,
	Grant Erickson <gerickson@nuovations.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 25 Nov 2008 12:53:12 -0600
"Matt Sealey" <matt@genesi-usa.com> wrote:

> Nitpick, really.. shouldn't the logbuffer location(s) be some device tree
> property(ies), perhaps something in the
> /chosen node that U-Boot etc. can then fill out?

I don't think that's a nitpick.  It's a fundamental change in how this
would all work.  However, I do think you're generally right.

Perhaps not /chosen, but maybe something like /rtas or /firmware, etc.

josh
