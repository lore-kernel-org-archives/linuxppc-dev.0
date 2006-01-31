Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id DAB8568A1F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Feb 2006 01:24:35 +1100 (EST)
Date: Tue, 31 Jan 2006 07:24:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: [RFC] arch/ppc/boot/simple/embed_boot.c : Merging all keyvals
	parsing code
Message-ID: <20060131142433.GN22672@smtp.west.cox.net>
References: <200601251215.10816.laurent.pinchart@tbox.biz>
	<200601251702.20332.laurent.pinchart@tbox.biz>
	<20060130172851.GF22672@smtp.west.cox.net>
	<200601310947.32463.laurent.pinchart@tbox.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200601310947.32463.laurent.pinchart@tbox.biz>
Cc: Dan Malek <dan@embeddedalley.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Jan 31, 2006 at 09:47:32AM +0100, Laurent Pinchart wrote:
> > No, that's good.  If you can cleanly merge the existing parsing code, by
> > all means please do so.  Thanks.
> 
> Ok I will. On which kernel tree should I base my patches on ?

I would suggest either Linus' current git tree or 2.6.16-rc1 if you don't
use git.  But please bear in mind that since this is a new feature (a new
board) it won't be submitted to Linus' tree until 2.6.17-rc1 opens up (and
if in that time, it becomes much easier to put this board under arch/powerpc
it should be done under there, instead).

-- 
Tom Rini
http://gate.crashing.org/~trini/
