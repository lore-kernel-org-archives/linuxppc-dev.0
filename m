Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0242.hostedemail.com
 [216.40.44.242])
 by lists.ozlabs.org (Postfix) with ESMTP id CC1CF1A0984
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 00:05:05 +1000 (AEST)
Date: Thu, 9 Apr 2015 10:04:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 3/3] powerpc: Include linux/jump_label.h to get
 HAVE_JUMP_LABEL define
Message-ID: <20150409100459.552e54d9@gandalf.local.home>
In-Reply-To: <1428551492-21977-3-git-send-email-anton@samba.org>
References: <1428551492-21977-1-git-send-email-anton@samba.org>
 <1428551492-21977-3-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: peterz@infradead.org, heiko.carstens@de.ibm.com, paulus@samba.org,
 hpa@zytor.com, mingo@kernel.org, linux@arm.linux.org.uk, mingo@redhat.com,
 mgorman@suse.de, catalin.marinas@arm.com, liuj97@gmail.com,
 linux-kbuild@vger.kernel.org, will.deacon@arm.com, jbaron@akamai.com,
 tglx@linutronix.de, mmarek@suse.cz, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  9 Apr 2015 13:51:32 +1000
Anton Blanchard <anton@samba.org> wrote:

> Commit 1bc9e47aa8e4 ("powerpc/jump_label: Use HAVE_JUMP_LABEL")
> converted uses of CONFIG_JUMP_LABEL to HAVE_JUMP_LABEL in
> some assembly files.
> 
> HAVE_JUMP_LABEL is defined in linux/jump_label.h, so we need to
> include this or we always get the non jump label fallback code.
> 
> Fixes: 1bc9e47aa8e4 ("powerpc/jump_label: Use HAVE_JUMP_LABEL")
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
