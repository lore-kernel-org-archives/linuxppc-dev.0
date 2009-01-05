Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 01264DE107
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 00:26:51 +1100 (EST)
In-Reply-To: <20090104182441.GA5086@linux.vnet.ibm.com>
References: <5414eaef99b7392a95f6e3488b81dbf7@bga.com>
	<20090104182441.GA5086@linux.vnet.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <98d6aef17cba9d835d7866745f811dc7@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] 2.6.28-git4 - powerpc - drivers build fails with
	!CONFIG_VIOPATH
Date: Mon, 5 Jan 2009 07:33:32 -0600
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jan 4, 2009, at 12:24 PM, Kamalesh Babulal wrote:

> Hi Milton,
>
> 	Thanks for the review comments, I am resending the patch with the
> changes you have recommended.
>
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Better, but you didn't include the change log, nor did you respond to 
Stephen's reply suggesting that all users be converted to select 
viopath (versus the proposed 2 select and 5 get it via depends and 
default y).

milton
