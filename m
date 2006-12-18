Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B0D2767D7E
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 03:54:06 +1100 (EST)
Date: Mon, 18 Dec 2006 10:51:41 -0600
From: Olof Johansson <olof@lixom.net>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Message-ID: <20061218105141.6482d1b9@localhost.localdomain>
In-Reply-To: <F6AD7E21CDF4E145A44F61F43EE6D939BA72A0@tmnt04.transmode.se>
References: <F6AD7E21CDF4E145A44F61F43EE6D939BA72A0@tmnt04.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 18 Dec 2006 15:44:14 +0100 "Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:

> The workqueue stuff has changed and needs to be adapted. Don't know how
> yet though. If you figure it out, drop a line.

Yeah, there's at least one more bug in there too (workqueue arguments).

I should have hardware to test on again a bit later this week; I'll
repost then.


-Olof
