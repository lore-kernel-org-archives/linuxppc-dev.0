Return-Path: <jikos@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdSLz38qkzDqYj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 20:06:35 +1100 (AEDT)
Date: Wed, 8 Mar 2017 10:06:30 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Jessica Yu <jeyu@redhat.com>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>,
 Chris J Arges <chris.j.arges@canonical.com>,
 Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v5 00/15] livepatch: hybrid consistency model
In-Reply-To: <cover.1487036215.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.20.1703081005130.31814@cbobk.fhfr.pm>
References: <cover.1487036215.git.jpoimboe@redhat.com>
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

On Mon, 13 Feb 2017, Josh Poimboeuf wrote:

> Here's v5 of the consistency model

I have ammended the patches with all the received ACKs and applied to 
'for-4.12/klp-hybrid-consistency-model' branch of livepatching.git.

Thanks,

-- 
Jiri Kosina
SUSE Labs
