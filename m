Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C9141A06B9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 15:49:26 +1100 (AEDT)
Message-ID: <1415076565.24950.6.camel@concordia>
Subject: Re: powerpc: Replace __get_cpu_var uses
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christoph Lameter <cl@linux.com>
Date: Tue, 04 Nov 2014 15:49:25 +1100
In-Reply-To: <alpine.DEB.2.11.1410211520470.20253@gentwo.org>
References: <alpine.DEB.2.11.1410211520470.20253@gentwo.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-10-21 at 15:23 -0500, Christoph Lameter wrote:
> This still has not been merged and now powerpc is the only arch that does
> not have this change. Sorry about missing linuxppc-dev before.

Hi Christoph,

I've put this in a topic branch, with the fixups I described last week:

  https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=topic/get-cpu-var

I'll pull this into my next when I open it.

cheers
