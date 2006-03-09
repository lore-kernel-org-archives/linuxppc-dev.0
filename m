Return-Path: <mgreer@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [63.81.120.158])
	by ozlabs.org (Postfix) with ESMTP id 7183A679E0
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Mar 2006 04:36:05 +1100 (EST)
Date: Thu, 9 Mar 2006 10:36:17 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Adrian Cox <adrian@humboldt.co.uk>
Subject: Re: [PATCH] Fix platform_notify functions marked __init
Message-ID: <20060309173617.GA29996@mag.az.mvista.com>
References: <1141855821.28095.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1141855821.28095.18.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 08, 2006 at 10:10:20PM +0000, Adrian Cox wrote:
> While adding USB support to an MV64360 based board this week, I
> discovered that all MV64x60 boards in the kernel have platform_notify
> functions marked with __init. This causes an oops if a device is added
> after boot.
> 
> The patch below removes the __init markers. I do not have all these
> boards to test on, but the change seems very unlikely to break anything
> else.

Arg...  I realized this a long time ago and fixed it in my tree.
Somewhere along the line, I dropped it, I guess.

Thanks for the patch Adrian.

Mark
