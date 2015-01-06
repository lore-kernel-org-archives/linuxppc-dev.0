Return-Path: <jbaron@akamai.com>
Received: from prod-mail-xrelay02.akamai.com (prod-mail-xrelay02.akamai.com
 [72.246.2.14])
 by lists.ozlabs.org (Postfix) with ESMTP id 686281A0928
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 02:55:02 +1100 (AEDT)
Message-ID: <54AC036E.6080507@akamai.com>
Date: Tue, 06 Jan 2015 10:46:54 -0500
From: Jason Baron <jbaron@akamai.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "mmarek@suse.cz" <mmarek@suse.cz>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "liuj97@gmail.com" <liuj97@gmail.com>,
 "mingo@kernel.org" <mingo@kernel.org>,
 "mgorman@suse.de" <mgorman@suse.de>, rostedt@goodmis.org
Subject: Re: [PATCH 1/2] jump_label: Allow jump labels to be used in assembly
References: <1420539628-17875-1-git-send-email-anton@samba.org>
In-Reply-To: <1420539628-17875-1-git-send-email-anton@samba.org>
Content-Type: text/plain; charset=windows-1252
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/06/2015 05:20 AM, Anton Blanchard wrote:
> To use jump labels in assembly we need the HAVE_JUMP_LABEL define,
> so we select a fallback version if the toolchain does not support
> them.
>
> Modify linux/jump_label.h so it can be included by assembly files.
> We also need to add -DCC_HAVE_ASM_GOTO to KBUILD_AFLAGS.
>
> Signed-off-by: Anton Blanchard <anton@samba.org>

(adding Steven)

Acked-by: Jason Baron <jbaron@akamai.com>

The jump label stuff often gets picked up by Steve, but I guess this
could go through the powerpc tree as well...

Thanks,

-Jason
