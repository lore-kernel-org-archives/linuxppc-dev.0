Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 3396167DF0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 02:29:10 +1000 (EST)
Date: Wed, 27 Jul 2005 09:29:07 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: John Otken <jotken@softadvances.com>, linuxppc-embedded@ozlabs.org
Message-ID: <20050727092907.A1114@cox.net>
References: <42E776DD.9080307@softadvances.com>
	<20050727155950.GA28681@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050727155950.GA28681@gate.ebshome.net>;
	from ebs@ebshome.net on Wed, Jul 27, 2005 at 08:59:51AM -0700
Subject: Re: [PATCH] Support for AMCC Yosemite 440EP Eval Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jul 27, 2005 at 08:59:51AM -0700, Eugene Surovegin wrote:
> On Wed, Jul 27, 2005 at 06:58:21AM -0500, John Otken wrote:
> > This patch adds support for the new AMCC Yosemite 440EP Eval
> > Board.  I tested it on the both Bamboo and Yosemite boards
> > using the 2.6.12 kernel.
> > 
> > This patch has three dependencies:
> > 2005-04-07 Wade Farnsworth's PPC440EP SoC and Bamboo board support
> 
> Why this old one? Updated patch was posted yesterday.

It should be noted that yesterday's patch is what I'm splitting to
send upstream.

-Matt
