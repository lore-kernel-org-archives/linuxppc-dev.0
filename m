Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17197.58312.715169.991104@cargo.ozlabs.ibm.com>
Date: Mon, 19 Sep 2005 08:01:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <432C23AE.6020800@hogyros.de>
References: <15A1D026-00E3-4652-ABA5-9A8B8517A2CA@freescale.com>
	<432C23AE.6020800@hogyros.de>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Reminder: removal of APUS and Gemini still pending
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Simon Richter writes:

> I have a tree that builds an APUS kernel (with Roman Zippel's patches 
> forwarded to HEAD), however I wanted to hold back with merging it until 
> the ppc/ppc64 -> powerpc transition is finished; also, I would like to 

That sounds like a mistake to me...

> get proper changesets with attribution instead of a big patch (the plan 
> is to forward-merge the changes until after the transition, then turn 
> them back into a diff and apply them step by step).

One of the things I particularly want to do is to remove the special
cases in the virtual<->physical address translations for APUS.
Perhaps the sparsemem or discontigmem code could be used instead?

Paul.
