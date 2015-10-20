Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1C791A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 11:44:43 +1100 (AEDT)
Message-ID: <1445301883.21485.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Add run_cmd function to boot wrapper
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@ozlabs.org
Date: Tue, 20 Oct 2015 11:44:43 +1100
In-Reply-To: <1445277206.30908.6.camel@infradead.org>
References: <1445230402-18087-1-git-send-email-mpe@ellerman.id.au>
 <1445277206.30908.6.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-10-19 at 10:53 -0700, Geoff Levand wrote:

> Add a boot wrapper script function run_cmd which will run a shell command
> quietly and only print the output if either V=1 or an error occurs.
> 
> Also, run the ps3 dd commands with run_cmd to clean up the build output.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
> Hi Michael,
> 
> How about something like this?  It seems a little cleaner.

Yeah great that's nice, I'll take it.

cheers
