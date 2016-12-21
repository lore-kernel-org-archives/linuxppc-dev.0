Return-Path: <mbenes@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tkGNf4p5szDwSh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 00:54:25 +1100 (AEDT)
Date: Wed, 21 Dec 2016 14:54:19 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>,
 Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>,
 Chris J Arges <chris.j.arges@canonical.com>,
 Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 04/15] livepatch/x86: add TIF_PATCH_PENDING thread flag
In-Reply-To: <b7bbfce2330e61329056e4567c68be8e4c55fb5b.1481220077.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.20.1612211453560.14423@pobox.suse.cz>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <b7bbfce2330e61329056e4567c68be8e4c55fb5b.1481220077.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 8 Dec 2016, Josh Poimboeuf wrote:

> Add the TIF_PATCH_PENDING thread flag to enable the new livepatch
> per-task consistency model for x86_64.  The bit getting set indicates
> the thread has a pending patch which needs to be applied when the thread
> exits the kernel.
> 
> The bit is placed in the _TIF_ALLWORK_MASK macro, which results in
> exit_to_usermode_loop() calling klp_update_patch_state() when it's set.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
