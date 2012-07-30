Return-Path: <greg@kroah.com>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 71F202C009B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 02:11:21 +1000 (EST)
Date: Mon, 30 Jul 2012 09:01:46 -0700
From: Greg KH <greg@kroah.com>
To: Singh Sandeep-B37400 <B37400@freescale.com>
Subject: Re: [2/3][PATCH][v2] TDM Framework
Message-ID: <20120730160146.GB28703@kroah.com>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20120727152542.GB1613@electric-eye.fr.zoreil.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E511121@039-SN1MPN1-006.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F1D9DCAAB49B94D88DBE05911FA4E6E511121@039-SN1MPN1-006.039d.mgd.msft.net>
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

On Mon, Jul 30, 2012 at 09:50:57AM +0000, Singh Sandeep-B37400 wrote:
> 1. You should send some kernel mode TDM clients. Without those the framework
>    is pretty useless.
> [Sandeep] We do have a test client but not good enough to be pushed in
> open source, should we add it to documentation?? 

Then how do you know if the framework is "correct" and good enough for
real clients?  We don't add frameworks, or apis, to the kernel without
users, so you will have to come up with some users before we can accept
it.

greg k-h
