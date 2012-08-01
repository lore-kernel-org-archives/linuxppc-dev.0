Return-Path: <B37400@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8C79D2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 22:13:35 +1000 (EST)
From: Singh Sandeep-B37400 <B37400@freescale.com>
To: Greg KH <greg@kroah.com>
Subject: RE: [2/3][PATCH][v2] TDM Framework
Date: Wed, 1 Aug 2012 12:13:19 +0000
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E515F98@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20120727152542.GB1613@electric-eye.fr.zoreil.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E511121@039-SN1MPN1-006.039d.mgd.msft.net>
 <20120730160146.GB28703@kroah.com>
In-Reply-To: <20120730160146.GB28703@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
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




> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Monday, July 30, 2012 9:32 PM
> To: Singh Sandeep-B37400
> Cc: Francois Romieu; devel@driverdev.osuosl.org; linuxppc-
> dev@lists.ozlabs.org; galak@kernel.crashing.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [2/3][PATCH][v2] TDM Framework
>=20
> On Mon, Jul 30, 2012 at 09:50:57AM +0000, Singh Sandeep-B37400 wrote:
> > 1. You should send some kernel mode TDM clients. Without those the
> framework
> >    is pretty useless.
> > [Sandeep] We do have a test client but not good enough to be pushed in
> > open source, should we add it to documentation??
>=20
> Then how do you know if the framework is "correct" and good enough for
> real clients?  We don't add frameworks, or apis, to the kernel without
> users, so you will have to come up with some users before we can accept
> it.
We can only say that this framework is available in FSL BSPs and being used=
 by VoIP companies.
But running a complete voice stack itself is beyond the scope of Freescale.
So vendors integrate their solutions with FSL solution.
To test the framework we have a small application in our BSP (this is a ver=
y basic test client) which tests the TDM driver and the SLIC interface from=
 voice  transfer perspective.
We can get this added in the Linux codebase in some test directory. What co=
uld be a good place for this?

Regards
Sandeep
