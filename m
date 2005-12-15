Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (sipsolutions.net [66.160.135.76])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 601EB68802
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Dec 2005 01:10:22 +1100 (EST)
From: Johannes Berg <johannes@sipsolutions.net>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <44B795CA-E338-4AAC-937D-F2EEA5E27EB9@kernel.crashing.org>
References: <1134569118.3875.9.camel@localhost>
	<17312.38814.551675.906916@cargo.ozlabs.ibm.com>
	<4590.131.234.232.31.1134639886.squirrel@secure.sipsolutions.net>
	<44B795CA-E338-4AAC-937D-F2EEA5E27EB9@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 15:10:01 +0100
Message-Id: <1134655801.5787.1.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: illegal instructions / irqs disabled warning
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Do, 2005-12-15 at 08:04 -0600, Kumar Gala wrote:

> Out of interest, is there a reason you dont handle the emulation in  
> user space?

I'm not even interested in emulating that at all, the kernel just
checked if it could emulate it (couldn't, so my program died with
SIGILL)...
To tell the truth, I was just testing what would happen and wrote a
buggy program.

johannes
