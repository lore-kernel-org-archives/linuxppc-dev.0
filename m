Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 537DADDD08
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 14:27:16 +1000 (EST)
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <99CD25DB-EAAC-4CF3-AB14-D825AD11E499@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 01/61] Use strcasecmp() rather than strncasecmp() when
	determining device node compatibility.
Date: Tue, 17 Jul 2007 23:27:44 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Can these patches be broken into logical clumps?

It seems like there are:

* bootwrapper
* misc cleanup
* 82xx
* 8xx
* fs_enet

Would be easier to review and obviously the fs_enet patches need to  
go via jeff and netdev.

- k
