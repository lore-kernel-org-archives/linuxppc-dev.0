Return-Path: <greg@kroah.com>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 536952C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 22:37:43 +1000 (EST)
Date: Wed, 1 Aug 2012 05:37:38 -0700
From: Greg KH <greg@kroah.com>
To: Singh Sandeep-B37400 <B37400@freescale.com>
Subject: Re: [2/3][PATCH][v2] TDM Framework
Message-ID: <20120801123738.GA28291@kroah.com>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20120727152542.GB1613@electric-eye.fr.zoreil.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E511121@039-SN1MPN1-006.039d.mgd.msft.net>
 <20120730160146.GB28703@kroah.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E515F98@039-SN1MPN1-001.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F1D9DCAAB49B94D88DBE05911FA4E6E515F98@039-SN1MPN1-001.039d.mgd.msft.net>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Francois Romieu <romieu@fr.zoreil.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2012 at 12:13:19PM +0000, Singh Sandeep-B37400 wrote:
> > On Mon, Jul 30, 2012 at 09:50:57AM +0000, Singh Sandeep-B37400 wrote:
> > > 1. You should send some kernel mode TDM clients. Without those the
> > framework
> > >    is pretty useless.
> > > [Sandeep] We do have a test client but not good enough to be pushed in
> > > open source, should we add it to documentation??
> > 
> > Then how do you know if the framework is "correct" and good enough for
> > real clients?  We don't add frameworks, or apis, to the kernel without
> > users, so you will have to come up with some users before we can accept
> > it.
> We can only say that this framework is available in FSL BSPs and being used by VoIP companies.
> But running a complete voice stack itself is beyond the scope of Freescale.
> So vendors integrate their solutions with FSL solution.
> To test the framework we have a small application in our BSP (this is a very basic test client) which tests the TDM driver and the SLIC interface from voice  transfer perspective.
> We can get this added in the Linux codebase in some test directory. What could be a good place for this?

tools/ is a good place for that.

And sorry, I was thinking you had kernel drivers that attached to this
framework, not userspace programs.  Actually, what is the user/kernel
interface for this framework, I seem to have missed that entirely.  You
will have to document that quite well, and run it by the linux-api
mailing list.

thanks,

greg k-h
