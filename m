Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 930E9DDECF
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 14:37:08 +1000 (EST)
Message-Id: <0B367446-4628-4633-BF66-A0007BD9A98B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1211136296-4572-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 0/4] minor fixes for 2.6.26
Date: Sun, 18 May 2008 23:37:01 -0500
References: <1211136296-4572-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 18, 2008, at 1:44 PM, Kumar Gala wrote:

> Please pull from 'for-2.6.26' branch of
>
> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git  
> for-2.6.26
>
> to receive the following updates:
>
> arch/powerpc/boot/.gitignore          |   15 ++-------------
> arch/powerpc/boot/Makefile            |    4 ++--
> arch/powerpc/boot/dts/mpc8377_mds.dts |   18 +++++++++++++-----
> lib/lmb.c                             |    2 +-
> 4 files changed, 18 insertions(+), 21 deletions(-)
>
> Kumar Gala (4):
>      lmb: Fix compile warning
>      [POWERPC] Remove generated files on make clean
>      [POWERPC] Update arch/powerpc/boot/.gitignore
>      [POWERPC] Fix mpc8377_mds.dts DMA nodes to match spec

Paul,

FYI, I've updated the git tree with v2 of the lmb patch if you decided  
to pull these patches from there.

- k
