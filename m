Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A0310B713E
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Sep 2010 07:24:42 +1000 (EST)
Subject: Re: [PATCH 3/3] PPC: Fix compilation of mpc85xx_mds.c
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1283220922-20369-4-git-send-email-agraf@suse.de>
Date: Tue, 31 Aug 2010 16:24:34 -0500
Message-Id: <B0F20320-FD2D-43B7-B327-5CA7A5741813@kernel.crashing.org>
References: <1283220922-20369-1-git-send-email-agraf@suse.de>
	<1283220922-20369-4-git-send-email-agraf@suse.de>
To: Alexander Graf <agraf@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Anton Vorontsov <avorontsov@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 30, 2010, at 9:15 PM, Alexander Graf wrote:

> Commit 99d8238f berobbed the for_each loop of its iterator! Let's be
> nice and give it back, so it compiles for us.
> 
> CC: Anton Vorontsov <avorontsov@mvista.com>
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied to merge

- k
