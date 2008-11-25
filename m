Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CB078DDDFB
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 12:04:40 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAP14QAl008610
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2008 20:04:26 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAP14aNr163470
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2008 20:04:36 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAP14EOx022518
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2008 20:04:15 -0500
Date: Mon, 24 Nov 2008 20:04:26 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the 4xx tree
Message-ID: <20081124200426.22cbe4c5@zod.rchland.ibm.com>
In-Reply-To: <20081125115021.b4782240.sfr@canb.auug.org.au>
References: <20081125115021.b4782240.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 25 Nov 2008 11:50:21 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Josh,
> 
> Today's linux-next merge of the 4xx tree got a conflict in
> arch/powerpc/configs/ppc44x_defconfig between commit
> c8d698849e135780738c2cb08f07f06eda982a8c ("powerpc/virtex: Update
> defconfigs") from the powerpc-merge tree and commit
> 867b71f3da64eb917c23cfd8babcd1c4fc0ba7fd ("powerpc/44x: update
> ppc44x_defconfig") from the 4xx tree.

Sigh.

> I fixed it up (by setting CONFIG_GPIO_XILINX to y as is done in the
> former).  I can carry this fix until either your tree is merged by Paul or
> you do a merge against the powerpc-merge tree (or Linus' tree after he
> takes Paul's tree).

I tend to rebase my next branch off of Paul's next branch, so if he
updates his tomorrow I can just do that and we will all be happy.  If
that isn't done by my afternoon time, I'll fix it up myself.  There's
no reason you should have to carry an extra patch.  linux-next is hard
enough :)

josh
