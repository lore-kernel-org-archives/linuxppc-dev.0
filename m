Return-Path: <sam@ravnborg.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by ozlabs.org (Postfix) with ESMTP id 1D9EB679EB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 May 2005 14:59:58 +1000 (EST)
Date: Wed, 11 May 2005 07:01:19 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: cpclark@xmission.com
Message-ID: <20050511050119.GC8025@mars.ravnborg.org>
References: <Pine.LNX.4.63.0505061718380.6288@xmission.xmission.com>
	<b0aede90eb15562c0dd5a44c10d1b965@freescale.com>
	<20050510042828.GA8398@mars.ravnborg.org>
	<Pine.LNX.4.63.0505100420380.8140@xmission.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.63.0505100420380.8140@xmission.xmission.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: PPC uImage build not reporting correctly
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 >
> > Looks ok - but I do not see why use of $(shell ...) did not work out.
> 
> As I understand it, the $(shell ...) construct doesn't "work" in the case 
> cited above because make evaluates/expands the $(shell ...) stuff while it 
> is parsing the makefile and building the command list--i.e. before it has 
> issued any commands to build anything.  What seems to be desired in this 
> case is a file-existence test which runs "inline" with respect to the 
> preceding commands.  The use of $(shell ...) inside a command 
> subverts/preempts that natural sequence.  I think. :-)

That explains it - thanks!

	Sam
