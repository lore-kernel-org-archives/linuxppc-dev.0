Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id 57DA067A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 07:45:34 +1100 (EST)
Date: Tue, 15 Feb 2005 13:45:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: morten.banzon@axxessit.no
Message-ID: <20050215204532.GG31436@smtp.west.cox.net>
References: <OFBD33500D.E8DD3F33-ONC1256FA9.006C5F4F-C1256FA9.006CFE15@axxessit.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFBD33500D.E8DD3F33-ONC1256FA9.006C5F4F-C1256FA9.006CFE15@axxessit.no>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] Adds mcc cpm commands
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Feb 15, 2005 at 08:50:11PM +0100, morten.banzon@axxessit.no wrote:
> Tom Rini <trini@kernel.crashing.org>
> 15.02.2005 20:23
> 
>  
>         To:     morten.banzon@axxessit.no
>         cc:     linuxppc-embedded@ozlabs.org
>         Subject:        Re: [PATCH][PPC32] Adds mcc cpm commands
> 
> 
> On Mon, Feb 14, 2005 at 01:56:07PM +0100, morten.banzon@axxessit.no wrote:
> 
> >> This patch adds mcc cpm commands to the cpm2.h file in the 2.6.10 
> kernel
> >> 
> >> Signed-off-by:  Morten Banzon  <morten.banzon at axxessit.no>
> 
> > What is this used for / needed by?  Thanks.
> 
> 
> > -- 
> > Tom Rini
> > http://gate.crashing.org/~trini/
> 
> This is needed for a MPC82xx MCC driver. Curently no MCC driver is in the 
> kernel.

OK.  I'd recommend holding off until 2.6.12 open then.  Thanks, and
queued.

-- 
Tom Rini
http://gate.crashing.org/~trini/
