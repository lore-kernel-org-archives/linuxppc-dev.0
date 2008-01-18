Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 37439DDEDB
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 02:18:53 +1100 (EST)
Message-Id: <1B0EDDAA-B8DE-44C8-B9BE-959B81B4F7C8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <4790BC58.3020606@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [alsa-devel] [PATCH v3] [POWERPC] Update MPC8610 HPCD to	support
	audio drivers
Date: Fri, 18 Jan 2008 09:18:14 -0600
References: <12000050651235-git-send-email-timur@freescale.com>	<12000050664035-git-send-email-timur@freescale.com>
	<Pine.LNX.4.64.0801180047460.16260@blarg.am.freescale.net>
	<4790BC58.3020606@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 18, 2008, at 8:48 AM, Timur Tabi wrote:

> Kumar Gala wrote:
>
>> Can you respin this.  It doesn't apply cleanly to my tree.
>
> Ok, but I have a feeling that the merge between alsa-git and powerpc- 
> git is going to be ugly.

Really, it would seem ok in that the powerpc stuff is only touch files  
under arch/powerpc.  So as long as the alsa is only touching files in  
drivers/ I think we'll be ok.  8610 my bitch a bit until the two exist  
in one place.

My merge conflict was because of updates/changes to booting-without- 
of.txt

- k
