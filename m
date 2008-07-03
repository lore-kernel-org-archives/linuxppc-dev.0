Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id C4222DDEDE
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 23:45:56 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: add of_find_next_property andof_get_aliased_index
Date: Thu, 3 Jul 2008 15:43:20 +0200
References: <1214424332-18496-1-git-send-email-timur@freescale.com>
	<200806262041.12275.sr@denx.de>
	<20080703093313.478e6773@zod.rchland.ibm.com>
In-Reply-To: <20080703093313.478e6773@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807031543.20417.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 03 July 2008, Josh Boyer wrote:
> > Now I have no idea how to support I2C on the other 4xx boards. Perhaps
> > Josh could advise how this should be done?
>
> As David said elsewhere, cell-index is fine for figuring out how to
> access the CPM registers, etc.  But it's not good for enumerating
> across the whole system.
>
> For I2C specifically, I think Sean already has a patch to switch the
> 4xx driver to not use the numbered functions, which eliminates the need
> for the enumeration all together.  That seems like the right approach
> to me.

Yes. I'm waiting for Sean's next patch version... :)

Best regards,
Stefan
