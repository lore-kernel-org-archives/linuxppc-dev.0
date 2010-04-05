Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id B953BB7CF8
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Apr 2010 05:32:17 +1000 (EST)
Received: by gyf2 with SMTP id 2so2101356gyf.15
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Apr 2010 12:32:15 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100405.121647.91426186.davem@davemloft.net>
References: <bda26c8d-00b2-411d-b4b7-ad6954b9049e@SG2EHSMHS005.ehs.local>
	<fa686aa41003171302v46738069pae51061ba83d0818@mail.gmail.com>
	<q2xfa686aa41004051110hc960e9a0sd1d5e61f7e2a5412@mail.gmail.com>
	<20100405.121647.91426186.davem@davemloft.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 5 Apr 2010 13:31:55 -0600
Message-ID: <t2qfa686aa41004051231v40d7b456y90f14abfca9a06bf@mail.gmail.com>
Subject: Re: [PATCH] [V2] Add non-Virtex5 support for LL TEMAC driver
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jtyner@cs.ucr.edu,
	michal.simek@petalogix.com, john.linn@xilinx.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 5, 2010 at 1:16 PM, David Miller <davem@davemloft.net> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Mon, 5 Apr 2010 12:10:51 -0600
>
>> David, are you going to pick up this patch, or would you like me to?
>
> The submitter, when asked, stated that he couldn't even get
> the driver to build on microblaze against mainline.
>
> So I marked the patch "changed requested" because being able
> to build is... you know... sort of a requirement for integration.

Heh, the current driver doesn't build on microblaze either.  However,
John, since you're removing the depends on PPC_DCR_NATIVE, can you
please respin the patch to make it depend on CONFIG_PPC and CONFIG_OF.
 Looking at it now I see that as-is it will cause collateral damage to
allmodconfig on every other architecture.

g.
