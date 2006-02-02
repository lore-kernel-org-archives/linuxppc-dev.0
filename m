Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 6A85D68A98
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 01:39:43 +1100 (EST)
Date: Thu, 2 Feb 2006 07:39:40 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Subject: Re: Yosemite/440EP why are readl()/ioread32()
	setuptoreadlittle-endian?
Message-ID: <20060202073940.C27740@cox.net>
References: <35786B99AB3FDC45A8215724617919736D921E@gbrwgceumf01.eu.xerox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35786B99AB3FDC45A8215724617919736D921E@gbrwgceumf01.eu.xerox.net>;
	from Clive.Jenkins@xerox.com on Thu, Feb 02, 2006 at 11:26:22AM -0000
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 02, 2006 at 11:26:22AM -0000, Jenkins, Clive wrote:
> I'm not sure all this fuss is justified in response to:
> 
> > What is the preferred way of accessing non-PCI devices then?
> > Direct pointer access?
> > Bye, Peter Korsgaard
> 
> Regardless of what standards or hardware might exist, I would be
> happy if Linux provided alternatives to readl()... that converted
> between big-endian and cpu-endian, so that I could write in my
> driver, for example:

As I pointed out, there are such alternatives. The iomap interface
provides what you need.

-Matt
