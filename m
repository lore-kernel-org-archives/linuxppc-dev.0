Return-Path: <adobriyan@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by ozlabs.org (Postfix) with ESMTP id 077AEB7D5C
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Mar 2010 22:24:36 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id e21so749122fga.3
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Mar 2010 04:24:34 -0700 (PDT)
Date: Sun, 14 Mar 2010 13:24:29 +0200
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christian Kujau <lists@nerdbynature.de>
Subject: Re: 2.6.34-rc1: Badness at fs/proc/generic.c:316
Message-ID: <20100314112428.GA4142@x200>
References: <alpine.DEB.2.01.1003131544340.5493@bogon.housecafe.de>
	<20100314065526.GA5353@x200>
	<alpine.DEB.2.01.1003140336280.5493@bogon.housecafe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.01.1003140336280.5493@bogon.housecafe.de>
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 14, 2010 at 03:39:39AM -0700, Christian Kujau wrote:
> On Sun, 14 Mar 2010 at 08:55, Alexey Dobriyan wrote:
> > > device-tree: Duplicate name in /cpus/PowerPC,G4@0, renamed to "l2-cache#1"
> > > name 'pulses/rev'
> > 
> > Uh-oh.
> 
> Uh-oh? :-)
> 
> >> Is this something to worry about? The machine seems to run fine so far...
> > 
> > Runtime behaviour remains the same, it's just new warning message.
> 
> So...the laptop probably won't blow up before -rc2 is out? :-)

Defitely not.

Post "find /proc/device-tree" output.
