Return-Path: <Simon.Richter@hogyros.de>
Received: from tuminfo2.informatik.tu-muenchen.de
	(tuminfo2.informatik.tu-muenchen.de [131.159.0.81])
	by ozlabs.org (Postfix) with ESMTP id 675DB682C5
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Sep 2005 00:31:13 +1000 (EST)
Message-ID: <432C23AE.6020800@hogyros.de>
Date: Sat, 17 Sep 2005 16:09:50 +0200
From: Simon Richter <Simon.Richter@hogyros.de>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <15A1D026-00E3-4652-ABA5-9A8B8517A2CA@freescale.com>
In-Reply-To: <15A1D026-00E3-4652-ABA5-9A8B8517A2CA@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Kumar Gala wrote:

> This is a reminder email to all those that care that APUS and Gemini  
> configs are still not building in the kernel.  They are still  scheduled 
> to be removed after the release of 2.6.15.

I have a tree that builds an APUS kernel (with Roman Zippel's patches 
forwarded to HEAD), however I wanted to hold back with merging it until 
the ppc/ppc64 -> powerpc transition is finished; also, I would like to 
get proper changesets with attribution instead of a big patch (the plan 
is to forward-merge the changes until after the transition, then turn 
them back into a diff and apply them step by step).

    Simon
