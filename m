Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E38EEDE00C
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 00:01:28 +1000 (EST)
In-Reply-To: <20071018070139.339e2efb@weaponx.rchland.ibm.com>
References: <200710181108.19413.yur@emcraft.com>
	<1192704248.13993.36.camel@localhost.localdomain>
	<1192707914.12879.51.camel@pasglop>
	<20071018070139.339e2efb@weaponx.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3192bd670c4e7814de0deb85a8556528@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
Date: Tue, 23 Oct 2007 16:00:34 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Requiring a modified binutils makes me a bit nervous though.

As long as those binutils modifications are sent upstream, I don't
see the problem?  If not, this would be a blocker IMHO.


Segher
