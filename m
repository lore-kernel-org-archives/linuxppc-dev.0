Return-Path: <anton@ozlabs.org>
Date: Tue, 20 Mar 2007 00:12:33 -0500
From: Anton Blanchard <anton@samba.org>
To: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc minor pagefault optimization with kprobes enabled
Message-ID: <20070320051233.GB31173@kryten>
References: <20070319133149.GA5781@infradead.org>
	<200703191500.34563.ak@suse.de>
	<20070319140851.GA11285@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070319140851.GA11285@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I've attached a patch below the optimizes this code path for powerpc,
> but the scheme applies to all architectures aswell.  It just rips out all
> the callachin madness, and does as good as it gets in the pagefault
> handler:

NAK, patch on the way to get rid of all the debugger() crap by using
this very hook.

Anton
