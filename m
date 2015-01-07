Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51F421A09B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 21:34:30 +1100 (AEDT)
Date: Wed, 7 Jan 2015 21:34:28 +1100
From: Anton Blanchard <anton@samba.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] jump_label: Allow jump labels to be used in assembly
Message-ID: <20150107213428.5ddb2095@kryten>
In-Reply-To: <20150106174822.GA29629@home.goodmis.org>
References: <1420539628-17875-1-git-send-email-anton@samba.org>
 <20150106174822.GA29629@home.goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: mmarek@suse.cz, linux-kbuild@vger.kernel.org, peterz@infradead.org,
 linux-kernel@vger.kernel.org, jbaron@akamai.com, paulus@samba.org,
 mgorman@suse.de, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 mingo@kernel.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Steve,

> Have you tested this on other archs? Because just looking at x86, it
> doesn't seem that asm/jump_label.h can handle being called in
> assembly.

Since no one is including linux/jump_label.h in assembly yet, nothing
should break. We could however add __ASSEMBLY__ protection to all the
asm/jump_label.h files. Patches on the way.

Anton
