Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5139C2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2012 00:13:51 +1000 (EST)
Date: Tue, 21 Aug 2012 15:13:37 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [2/3][PATCH][v2] TDM Framework
Message-ID: <20120821141336.GD21557@sirena.org.uk>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20120727152542.GB1613@electric-eye.fr.zoreil.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E511121@039-SN1MPN1-006.039d.mgd.msft.net>
 <20120730160146.GB28703@kroah.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E515F98@039-SN1MPN1-001.039d.mgd.msft.net>
 <20120801123738.GA28291@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120801123738.GA28291@kroah.com>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Francois Romieu <romieu@fr.zoreil.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Singh Sandeep-B37400 <B37400@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2012 at 05:37:38AM -0700, Greg KH wrote:
> On Wed, Aug 01, 2012 at 12:13:19PM +0000, Singh Sandeep-B37400 wrote:

> > But running a complete voice stack itself is beyond the scope of Freescale.
> > So vendors integrate their solutions with FSL solution.

> And sorry, I was thinking you had kernel drivers that attached to this
> framework, not userspace programs.  Actually, what is the user/kernel
> interface for this framework, I seem to have missed that entirely.  You
> will have to document that quite well, and run it by the linux-api
> mailing list.

This does also sound like we ought to be playing nicer with ALSA rather
than just providing a binary only pipe...
