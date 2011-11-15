Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B0ACCB6F8A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 09:29:25 +1100 (EST)
Message-ID: <1321396146.3170.11.camel@pasglop>
Subject: Re: [RFC PATCH 0/2] powerpc: CPU cache op cleanup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Date: Wed, 16 Nov 2011 09:29:06 +1100
In-Reply-To: <1321324332-22964-1-git-send-email-Kyle.D.Moffett@boeing.com>
References: <1320986410.21206.48.camel@pasglop>
 <1321324332-22964-1-git-send-email-Kyle.D.Moffett@boeing.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: B04825@freescale.com, linux-kernel@vger.kernel.org,
 paul.gortmaker@windriver.com, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-11-14 at 21:32 -0500, Kyle Moffett wrote:
> Unfortunately, I've been staring at PPC asm for long enough that I
> have a migraine headache and I'm going to have to stop here for now.
> If somebody else wants to tackle fixing up the 32-bit copy_page() and
> __copy_tofrom_user() routines it would be highly appreciated. 

Yeah that's the one everybody's avoiding :-)

What about my idea of instead compiling it multiple times with a
different size and fixing up the branch to call the right one ?

Cheers,
Ben.
