Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [194.246.123.103])
	by ozlabs.org (Postfix) with ESMTP id A9601B6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jun 2011 13:02:52 +1000 (EST)
Date: Tue, 31 May 2011 20:02:47 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 3.0-rc1: powerpc hangs at Kernel virtual memory layout
In-Reply-To: <alpine.DEB.2.01.1105311744000.21697@trent.utfs.org>
Message-ID: <alpine.DEB.2.01.1105311959000.21697@trent.utfs.org>
References: <alpine.DEB.2.01.1105311644010.21697@trent.utfs.org>
	<1306887942.29297.10.camel@pasglop>
	<alpine.DEB.2.01.1105311744000.21697@trent.utfs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(Cc'in Linus)

On Tue, 31 May 2011 at 17:48, Christian Kujau wrote:
> In the meantime, "git bisect" behaves kinda weird, I don't know what went 
> wrong here:
> 
>  $ git bisect start
>  $ git bisect good         # Linux 2.6.39
>  $ git bisect bad v3.0-rc1 # Linux 3.0-rc1
>  $ git bisect bad          # c44dead70a...
>  $ git bisect bad          # d93515611b..
> 
> ...yet the ./Makefile shows[0] that I'm already way behind: 2.6.39-rc2. 
> Maybe "git bisect" got confused with that whole 2.6.x -> 3.0 renaming?

Hm, I tried again, from a clean v3.0-rc1 (git reset --hard), but after the 
2nd "git bad" I'm at 2.6.39-rc2 again - while I /should/ be somwhere 
inbetween v2.6.39..v3.0-rc1, right?

Help, please!
Christian.

[0] http://nerdbynature.de/bits/3.0-rc1/
-- 
BOFH excuse #54:

Evil dogs hypnotised the night shift
