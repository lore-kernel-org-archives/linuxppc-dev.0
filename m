Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id CD0A867A6F
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Mar 2005 09:19:14 +1100 (EST)
Date: Wed, 16 Mar 2005 15:19:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
Message-ID: <20050316221907.GB8345@smtp.west.cox.net>
References: <4236B7E5.8030402@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4236B7E5.8030402@jp.fujitsu.com>
Cc: linuxppc-dev@ozlabs.org, tmm@tmm.dk
Subject: Re: [PATCH]  boot time scheduling w hile atomic  fix
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 15, 2005 at 07:24:37PM +0900, Takeharu KATO wrote:

[snip]
> As I mentioned before, it was caused by calling kernel_thread function via
> trap call.
> 
> So, I've replaced the implementation of kernel_thread with function call like as
> other architectures.
> 
> I tested this patch on PowerPC440GP (ebony evaluation board).

This is a great first start.  But please see
Documentation/SubmittingPatches and provide a Signed-off-by line and
resubmit.  Thanks!

-- 
Tom Rini
http://gate.crashing.org/~trini/
