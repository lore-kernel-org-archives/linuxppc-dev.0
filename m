Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 833602BC0F
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Oct 2004 01:33:39 +1000 (EST)
Date: Mon, 25 Oct 2004 08:33:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Message-ID: <20041025153337.GE25154@smtp.west.cox.net>
References: <20041024160923.GA22167@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041024160923.GA22167@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] write gas check tmp file to O= directory
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 24, 2004 at 06:09:23PM +0200, Olaf Hering wrote:

> the tmp file should be in the O= directory.

It is already.  By changing AS_ALTIVEC to be just $(shell pwd) and
adding an echo to checkbin we see:
echo /home/trini/work/kernel/pristine/amit-kgdb/linux-2.6.9/lopec

So this isn't an issue.

> 
> btw, why does the mftb check not use '$?'?

It was either that I saw different binutils fail with different exit
codes, or testing for 03041 looked better than '0304255' or whatever the
exit code was.

-- 
Tom Rini
http://gate.crashing.org/~trini/
