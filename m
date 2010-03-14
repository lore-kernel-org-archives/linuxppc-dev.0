Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 475CDB7D56
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Mar 2010 21:39:45 +1100 (EST)
Date: Sun, 14 Mar 2010 03:39:39 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: 2.6.34-rc1: Badness at fs/proc/generic.c:316
In-Reply-To: <20100314065526.GA5353@x200>
Message-ID: <alpine.DEB.2.01.1003140336280.5493@bogon.housecafe.de>
References: <alpine.DEB.2.01.1003131544340.5493@bogon.housecafe.de>
	<20100314065526.GA5353@x200>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 14 Mar 2010 at 08:55, Alexey Dobriyan wrote:
> > device-tree: Duplicate name in /cpus/PowerPC,G4@0, renamed to "l2-cache#1"
> > name 'pulses/rev'
> 
> Uh-oh.

Uh-oh? :-)

>> Is this something to worry about? The machine seems to run fine so far...
> 
> Runtime behaviour remains the same, it's just new warning message.

So...the laptop probably won't blow up before -rc2 is out? :-)

Christian.
-- 
BOFH excuse #298:

Not enough interrupts
