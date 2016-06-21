Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYn6Z3337zDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 22:27:18 +1000 (AEST)
In-Reply-To: <1465439470-15456-3-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, Jack Miller <jack@codezen.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com,
 anton@samba.org
Subject: Re: [v7,2/3] powerpc: Load Monitor Register Support
Message-Id: <3rYn6Z27nbz9sxb@ozlabs.org>
Date: Tue, 21 Jun 2016 22:27:18 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-09-06 at 02:31:09 UTC, Michael Neuling wrote:
> From: Jack Miller <jack@codezen.org>
> 
> This enables new registers, LMRR and LMSER, that can trigger an EBB in
> userspace code when a monitored load (via the new ldmx instruction)
> loads memory from a monitored space. This facility is controlled by a
> new FSCR bit, LM.
> 
> This patch disables the FSCR LM control bit on task init and enables
> that bit when a load monitor facility unavailable exception is taken
> for using it. On context switch, this bit is then used to determine
> whether the two relevant registers are saved and restored. This is
> done lazily for performance reasons.
> 
> Signed-off-by: Jack Miller <jack@codezen.org>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bd3ea317fddfd0f2044f94bed2

cheers
