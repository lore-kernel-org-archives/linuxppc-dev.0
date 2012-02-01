Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E3EBBB6EF7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 23:58:02 +1100 (EST)
Date: Wed, 1 Feb 2012 12:32:31 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Question about GPIO Lib
Message-ID: <20120201123231.GB13723@sirena.org.uk>
References: <OF2BD13139.450D178D-ON88257992.0018BB93-88257992.0018CFCA@selinc.com>
 <CADkCAusUm3_hNY3MYQOPcEnuw-91PHUMF9Yx6mwcM+WeJG50+Q@mail.gmail.com>
 <OF0788007E.17A6C7B1-ON88257996.00000E0C-88257996.00009D99@selinc.com>
 <CADkCAuvkWvBLbDwhDFBdZ0mGoPv5HyZSD-ivXPyTKbMo_9GXvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADkCAuvkWvBLbDwhDFBdZ0mGoPv5HyZSD-ivXPyTKbMo_9GXvg@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Bruce_Leonard@selinc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 31, 2012 at 10:39:05AM -0600, Bill Gatliff wrote:

> I'm just saying that, sadly, in many ways gpiolib is still a
> work-in-progress.  The userspace component has been somewhat
> controversial in general over the years, and definitely lacks several
> key features in addition to the one you are asking for.

Just to expand on this a bit: lots of people would prefer not to have a
userspace component at all due to the same hardware safety concerns that 
you have, or to have the userspace component be a driver using gpiolib
which needs to be explicitly connected to the GPIOs.
