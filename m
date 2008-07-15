Return-Path: <jwboyer@gmail.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.240])
	by ozlabs.org (Postfix) with ESMTP id D9FE1DDFA2
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 22:13:25 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so1680567hsz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 05:13:24 -0700 (PDT)
Subject: Re: powerpc.git merge status
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
In-Reply-To: <1216101729.7740.84.camel@pasglop>
References: <1216101729.7740.84.camel@pasglop>
Content-Type: text/plain
Date: Tue, 15 Jul 2008 07:55:12 -0400
Message-Id: <1216122912.14579.52.camel@weaponx>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-15 at 16:02 +1000, Benjamin Herrenschmidt wrote:
> Now, regarding the remaining bits, still on my todo for the next batch,
> probably later this week, in this merge window:

<snip>

> 	- Kumar PTE bits... that's a bit "hot" for this merge window
>           but I suppose it can still make it.

I'd argue that they should make it.  It's parity with your PTE rework
for 44x, and Kumar even found a bug (which you've pulled the fix for) in
your implementation :).

josh
