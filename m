Return-Path: <mchan@broadcom.com>
Received: from mms2.broadcom.com (mms2.broadcom.com [216.31.210.18])
	by ozlabs.org (Postfix) with ESMTP id 91842DE0B0
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 02:32:29 +1000 (EST)
Subject: Re: dead network on JS21 with tg3 driver after flowcontrol
 changes
From: "Michael Chan" <mchan@broadcom.com>
To: "Olaf Hering" <olaf@aepfle.de>
In-Reply-To: <20080515154948.GA23647@aepfle.de>
References: <20080515121340.GA23033@aepfle.de>
	<1551EAE59135BE47B544934E30FC4FC002AABCEE@nt-irva-0751.brcm.ad.broadcom.com>
	<20080515154948.GA23647@aepfle.de>
Date: Thu, 15 May 2008 10:37:07 -0700
Message-ID: <1210873027.22745.0.camel@dell>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, Matthew Carlson <mcarlson@broadcom.com>,
	netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-05-15 at 17:49 +0200, Olaf Hering wrote:
> On Thu, May 15, Michael Chan wrote:
> 
> > Olaf Hering wrote:
> > 
> > > Any ideas how to fix this?
> > > What info do you need from the system?
> > 
> > Are you using eth0 or eth1?  The dmesg below shows that
> > link came up on eth1 and IP address from DHCP was received.
> 
> I'm using eth1.
> The log was done with the patch reverted.
> 

In that case, please re-apply the patch and provide mii-tool -vvv eth1.
