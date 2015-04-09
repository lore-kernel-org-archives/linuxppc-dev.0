Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0200.hostedemail.com
 [216.40.44.200])
 by lists.ozlabs.org (Postfix) with ESMTP id 6655A1A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 00:04:00 +1000 (AEST)
Date: Thu, 9 Apr 2015 10:03:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 2/3] jump_label: Allow jump labels to be used in assembly
Message-ID: <20150409100355.16d5e32a@gandalf.local.home>
In-Reply-To: <1428551492-21977-2-git-send-email-anton@samba.org>
References: <1428551492-21977-1-git-send-email-anton@samba.org>
 <1428551492-21977-2-git-send-email-anton@samba.org>
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

On Thu,  9 Apr 2015 13:51:31 +1000
Anton Blanchard <anton@samba.org> wrote:

> To use jump labels in assembly we need the HAVE_JUMP_LABEL define,
> so we select a fallback version if the toolchain does not support
> them.
> 
> Modify linux/jump_label.h so it can be included by assembly files.
> We also need to add -DCC_HAVE_ASM_GOTO to KBUILD_AFLAGS.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
