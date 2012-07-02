Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DE1042C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 07:27:17 +1000 (EST)
Message-ID: <1341264431.2588.50.camel@pasglop>
Subject: Re: [PATCH][v2] PPC: use CURRENT_THREAD_INFO instead of open coded
 assembly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stuart Yoder <stuart.yoder@freescale.com>
Date: Tue, 03 Jul 2012 07:27:11 +1000
In-Reply-To: <1341263667-29875-1-git-send-email-stuart.yoder@freescale.com>
References: <1341263667-29875-1-git-send-email-stuart.yoder@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-07-02 at 16:14 -0500, Stuart Yoder wrote:
> -v2
>    -moved CURRENT_THREAD_INFO under assembly only
>     #ifdef 

Nak, invert the two cases to avoid the if_n_def, but don't move it
inside __ASSEMBLY__ only.

IE. Address Alex other comment :-)

Cheers,
Ben.
