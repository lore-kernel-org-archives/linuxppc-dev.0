Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7401BDDE49
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 10:54:40 +1000 (EST)
In-Reply-To: <A0830B08-2A3A-4BC1-BAAB-82D1C1D3CB7E@kernel.crashing.org>
References: <A0830B08-2A3A-4BC1-BAAB-82D1C1D3CB7E@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4948353cd5e9c566a8151eca8c4bbcb7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: still using stabs debug format?
Date: Sat, 18 Aug 2007 02:54:27 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Ed Swarthout <Ed.Swarthout@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Is anyone really still using the stabs format for kernel debug?
>
> can we kill off the .stabs references?

What, you want to replace them with dwarf markup?  Or just
get rid of the debug info completely?


Segher
