Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1962ADDEA0
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 01:27:52 +1100 (EST)
Message-Id: <AF4B8466-C1CE-4FFB-8341-4BFC1CB76116@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Zhang Wei <wei.zhang@freescale.com>
In-Reply-To: <12016890773706-git-send-email-wei.zhang@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 4/6] Add multi mport support.
Date: Wed, 30 Jan 2008 08:27:44 -0600
References: <1201689053956-git-send-email-wei.zhang@freescale.com>
	<12016890621727-git-send-email-wei.zhang@freescale.com>
	<120168907160-git-send-email-wei.zhang@freescale.com>
	<12016890773706-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 30, 2008, at 4:30 AM, Zhang Wei wrote:

> Change lots of static variable to mport private. And add mport to some
> function declaration.

Can you explain this patch further.  Its not clear exactly from this  
commit message why we are doing this.

- k
