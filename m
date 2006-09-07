Return-Path: <mporter@embeddedalley.com>
Received: from matthew-porters-computer.local (cpe-088197.static.wadsnet.net
	[65.114.88.197]) by ozlabs.org (Postfix) with ESMTP id BA04367B7F
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2006 03:20:12 +1000 (EST)
Date: Thu, 7 Sep 2006 13:20:06 -0400
From: Matt Porter <mporter@embeddedalley.com>
To: Josh Boyer <jdub@us.ibm.com>
Subject: Re: [PATCH] [v3] PPC 4xx: Enable XMON on PPC 4xx boards
Message-ID: <20060907172006.GA498@matthew-porters-computer.local>
References: <1157639720.6098.49.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1157639720.6098.49.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 07, 2006 at 09:35:20AM -0500, Josh Boyer wrote:
> The following patch allows XMON to run on the 4xx platform.  Tested on
> Walnut, Ebony, and Nova (440GX based) eval boards.  440EP and 440SP boards
> should work as well.  Patch is against 2.6.18-rc6.
> 
> Signed-off-by: Josh Boyer <jdub@us.ibm.com>

ACK

Thanks for pointing out that 440SP needed a different case as well.

-Matt
