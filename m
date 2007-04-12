Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 0302BDDF65
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 23:49:41 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <1176382146.6379.28.camel@zod.rchland.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <89c4d64a1c2e654c8f339f008bbeddeb@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: Fix PowerPC 750CL CPU features 
Date: Thu, 12 Apr 2007 08:49:14 -0500
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu Apr 12 22:49:06 EST 2007, Josh Boyer wrote:
> PowerPC 750CL has high BATs.  The patch below sets cpu_features to 
> match that.
> Without it, the original firmware mappings in the high BATs aren't 
> cleared
> which can cause "odd" address translations to occur.

Lets say what it does:  which continue to override the linux 
translations.

milton
