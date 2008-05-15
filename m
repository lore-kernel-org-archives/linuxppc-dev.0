Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 35C55DE0EF
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 06:31:08 +1000 (EST)
Date: Thu, 15 May 2008 16:31:04 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] 4xx: Workaround for CHIP_11 Errata
Message-ID: <20080515163104.18f0a613@lappy.seanm.ca>
In-Reply-To: <20080515094346.3338e1f3@zod.rchland.ibm.com>
References: <20080515094346.3338e1f3@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 15 May 2008 09:43:46 -0500
"Josh Boyer" <jwboyer@linux.vnet.ibm.com> wrote:

> This implements the recommended workaround for this errata for chips
> that use older versions of firmware that do not already handle it.
> The last 4KiB of memory are hidden from the kernel to prevent the
> problem transactions from occurring.

Do you know which versions of firmware have this problem?

Cheers,
   Sean
