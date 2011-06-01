Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [194.246.123.103])
	by ozlabs.org (Postfix) with ESMTP id 0E92EB6F7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jun 2011 11:08:55 +1000 (EST)
Date: Tue, 31 May 2011 18:08:51 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 3.0-rc1: powerpc hangs at Kernel virtual memory layout
In-Reply-To: <alpine.DEB.2.01.1105311744000.21697@trent.utfs.org>
Message-ID: <alpine.DEB.2.01.1105311806220.21697@trent.utfs.org>
References: <alpine.DEB.2.01.1105311644010.21697@trent.utfs.org>
	<1306887942.29297.10.camel@pasglop>
	<alpine.DEB.2.01.1105311744000.21697@trent.utfs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 31 May 2011 at 17:48, Christian Kujau wrote:
> On Wed, 1 Jun 2011 at 10:25, Benjamin Herrenschmidt wrote:
> > Hrm, I had it working on a pair of powerbooks yesterday. Can you try
> > something like "udbg-immortal" on your kernel command line to see if
> > that makes a difference in the output ?
> 
> I'll try in a minute.

Wow, it really did make a difference:

  http://nerdbynature.de/bits/3.0-rc1/
  * linux-3.0_powerpc_2.jpg
  * linux-3.0_powerpc_2.mp4 (only a few(!) seconds long,
    best to view with the slider in VLC oder Quicktime, to
    get at least a grasp what lead to linux-3.0_powerpc_2.jpg)

Thanks,
Christian.
-- 
BOFH excuse #45:

virus attack, luser responsible
