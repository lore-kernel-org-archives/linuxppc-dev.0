Return-Path: <RFeany@mrv.com>
Received: from bos-spam.mrv.com (mx5.mrv.com [140.179.254.12])
	by ozlabs.org (Postfix) with ESMTP id 25268B6F00
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Nov 2009 07:28:43 +1100 (EST)
Date: Fri, 20 Nov 2009 12:28:38 -0800
From: Rex Feany <RFeany@mrv.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 00/10 v6]  Fix 8xx MMU/TLB
Message-ID: <20091120202838.GA25843@compile2.chatsunix.int.mrv.com>
References: <1258712471-3104-1-git-send-email-Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1258712471-3104-1-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thus spake Joakim Tjernlund (Joakim.Tjernlund@transmode.se):

> Yet again an iteration of the series.
> Rex & Scott, please test and signoff.
> Changes since last version:
>  - Fix rlwimi insn(from Scott)

Hi Joakim,

Things look much better with this patch set, I see none
of the random crashes that I had with the earlier patches.
I'll leave it running on a few boards here over the weekend and
see if anything bad happens. 

Since patch #1 fixes a regression in the current kernel
is there any way you can get that into .32? I know it is late,
but without that patch .32 doesn't work for 8xx boards.

On another note, how does your patch set affect performance?
Have you been able to do any testing?  What is the advantage
of using dcbX in the kernel, besides keeping the code
similar to other ppc platforms?  Maybe it is good to
catch/fixup userspace uses of dcbX, but why change the
kernel? How does it affect performance?

thanks!
/rex.
