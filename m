Return-Path: <mbenes@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySvZn5b0YzDrD1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Nov 2017 19:02:56 +1100 (AEDT)
Date: Fri, 3 Nov 2017 09:02:50 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: jeyu@kernel.org, jikos@kernel.org, pmladek@suse.com, lpechacek@suse.cz,
 pavel@ucw.cz, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] livepatch: send a fake signal to all blocking tasks
In-Reply-To: <20171102130916.y4jl5a2tuhkivpcr@treble>
Message-ID: <alpine.LSU.2.21.1711030902250.31648@pobox.suse.cz>
References: <20171031114853.841-1-mbenes@suse.cz>
 <20171031114853.841-2-mbenes@suse.cz>
 <20171102130916.y4jl5a2tuhkivpcr@treble>
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

On Thu, 2 Nov 2017, Josh Poimboeuf wrote:

> On Tue, Oct 31, 2017 at 12:48:52PM +0100, Miroslav Benes wrote:
> > +
> > +/*
> > + * Sends a fake signal to all non-kthread tasks with TIF_PATCH_PENDING set.
> > + * Kthreads with TIF_PATCH_PENDING set are woken up. Only admin can request this
> > + * action currently.
> > + */
> > +void klp_force_signals(void)
> 
> Since "force" now has a separate meaning, it's a little confusing to
> have it in the name of this function.  How about klp_send_signals() or
> klp_signal()?

or klp_send_signal()?

Miroslav
