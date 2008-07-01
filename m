Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A404DDEE3
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 15:28:32 +1000 (EST)
Message-Id: <D004D562-9B53-4241-947D-07D32CEF7262@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <20080520193917.C7ED15AF22@innovsys.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] Fix cpm uart corruption with PREEMPT_RT
Date: Tue, 1 Jul 2008 00:28:10 -0500
References: <20080520193917.C7ED15AF22@innovsys.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 20, 2008, at 2:39 PM, Rune Torgersen wrote:

> Fix CPM serial port corruption when running with CONFIG_PREEMPT_RT.
> Userland usage of console, and kernel printf's were stepping on each  
> others toes.
> Also only take lock if not in an oops.
>
> Signed-off-by: Rune Torgersen <runet@innovsys.com>

applied.

- k
