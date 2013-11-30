Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 by ozlabs.org (Postfix) with ESMTP id 2FC722C009D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Nov 2013 21:11:57 +1100 (EST)
Date: Sat, 30 Nov 2013 02:11:53 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 3.13-rc1: eth0 hw csum failure on powerpc
In-Reply-To: <alpine.DEB.2.11.1311300156380.31521@trent.utfs.org>
Message-ID: <alpine.DEB.2.11.1311300210360.31521@trent.utfs.org>
References: <alpine.DEB.2.11.1311300156380.31521@trent.utfs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 30 Nov 2013 at 02:07, Christian Kujau wrote:
> while trying to upgrade from 3.12.0 to 3.13-rc1 or -rc2, the following 
> happens early during bootup:
> 
> [...]
>  Freeing unused kernel memory: 204K (c06ea000 - c071d000)
>  eth0: hw csum failure
>  CPU: 0 PID: 0 Comm: swapper Not tainted 3.13.0-rc2 #1
>  Call Trace:

Btw, full dmesg & .config:  http://nerdbynature.de/bits/3.13-rc1/

C.
-- 
BOFH excuse #449:

greenpeace free'd the mallocs
