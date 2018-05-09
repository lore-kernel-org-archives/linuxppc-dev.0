Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gt2C27vhzF276
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 20:31:47 +1000 (AEST)
Date: Wed, 9 May 2018 12:35:13 +0200
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, live-patching@vger.kernel.org
Subject: Re: [PATCH v3] ppc64le livepatch: implement reliable stacktrace
 for newer consistency models
Message-ID: <20180509103513.GA24464@lst.de>
References: <20180305164928.GA17953@lst.de>
 <20180308162616.yhbymodggnfzpskx@treble>
 <20180309174718.2700b29e@blackhole.lan>
 <20180312153536.7avozx64ku4lvd3e@treble> <20180504123834.GA16581@lst.de>
 <20180507154208.jo4s43olrf5a3hw4@treble>
 <20180508103832.085378b9@blackhole.lan>
 <20180509001432.5nd55ictwf5yi7sm@treble>
 <87sh71zjuy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87sh71zjuy.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 09, 2018 at 11:41:09AM +1000, Michael Ellerman wrote:
> Josh Poimboeuf <jpoimboe@redhat.com> writes:
> 
> > Generally we refer to it as "the consistency model".
[...]
> 
> We use "powerpc" as the prefix.
> 
> So I've used:
> 
>   powerpc/livepatch: Implement reliable stack tracing for the consistency model

Perfect. Thanks!

	Torsten
