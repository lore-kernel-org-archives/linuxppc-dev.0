Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 75F6ADDFB8
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 23:52:55 +1000 (EST)
In-Reply-To: <20071008222503.25840.37660.stgit@trillian.cg.shawcable.net>
References: <20071008222445.25840.6561.stgit@trillian.cg.shawcable.net>
	<20071008222503.25840.37660.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E82FBA5B-61A0-4A0A-886B-0FCDD6AFC255@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/6] Platforms shouldn't mess with ROOT_DEV
Date: Tue, 9 Oct 2007 08:53:08 -0500
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 8, 2007, at 5:25 PM, Grant Likely wrote:

> From: Grant Likely <grant.likely@secretlab.ca>
>
> There is no good reason for board platform code to mess with the  
> ROOT_DEV.
> Remove it from all in-tree platforms except powermac
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
>  arch/powerpc/platforms/52xx/efika.c          |    9 ---------
>  arch/powerpc/platforms/52xx/lite5200.c       |   12 ------------
>  arch/powerpc/platforms/8xx/mpc86xads_setup.c |    2 --
>  arch/powerpc/platforms/cell/setup.c          |    5 -----
>  arch/powerpc/platforms/celleb/setup.c        |    5 -----
>  arch/powerpc/platforms/chrp/setup.c          |   10 ----------
>  arch/powerpc/platforms/pseries/setup.c       |    5 -----
>  7 files changed, 0 insertions(+), 48 deletions(-)

I'd drop mpc86xads_setup since I think Scott's rework will deal with it.

- k
