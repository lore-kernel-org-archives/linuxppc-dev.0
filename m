Return-Path: <adobriyan@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by ozlabs.org (Postfix) with ESMTP id DD6BEB7D50
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Mar 2010 17:55:35 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id e21so719666fga.3
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Mar 2010 22:55:33 -0800 (PST)
Date: Sun, 14 Mar 2010 08:55:26 +0200
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christian Kujau <lists@nerdbynature.de>
Subject: Re: 2.6.34-rc1: Badness at fs/proc/generic.c:316
Message-ID: <20100314065526.GA5353@x200>
References: <alpine.DEB.2.01.1003131544340.5493@bogon.housecafe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.01.1003131544340.5493@bogon.housecafe.de>
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 13, 2010 at 03:53:28PM -0800, Christian Kujau wrote:
> after upgrading from 2.6.33 to today's latest mainline (daf9fe2...), I'm 
> getting this during bootup on a powerpc machine (Powerbook G4):
> 
> [    0.002187] ------------[ cut here ]------------
> [    0.002197] Badness at fs/proc/generic.c:316

> device-tree: Duplicate name in /cpus/PowerPC,G4@0, renamed to "l2-cache#1"
> name 'pulses/rev'

Uh-oh.

> Is this something to worry about? The machine seems to run fine so far...

Runtime behaviour remains the same, it's just new warning message.
