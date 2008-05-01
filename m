Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE457DDE0C
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 10:37:27 +1000 (EST)
Subject: Re: [PATCH v4] sysdev,mv64x60: MV64x60 device bus
From: Remi Machet <rmachet@slac.stanford.edu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080501095448.7ddfffb3.sfr@canb.auug.org.au>
References: <1209574037.14407.57.camel@pcds-ts102.slac.stanford.edu>
	<20080501095448.7ddfffb3.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Wed, 30 Apr 2008 17:37:46 -0700
Message-Id: <1209602267.14407.80.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yes, I am sorry. I will post another patch in a few minutes ...

Remi

On Thu, 2008-05-01 at 09:54 +1000, Stephen Rothwell wrote:
> Hi Remi,
> 
> On Wed, 30 Apr 2008 09:47:16 -0700 Remi Machet <rmachet@slac.stanford.edu> wrote:
> >
> > For each mv64360 entry in the OpenFirmware database, add the 
> > registration of an of_bus to take care of devices connected to
> > the MV64x60 asynchronous devices controller.
> > This change makes it possible for those devices to be detected by 
> > drivers that support the of_platform without having a custom call 
> > for each of them in the board file.
> > 
> > Signed-off-by: Remi Machet (rmachet@slac.stanford.edu)
> 
> You really should use '<' and '>' to surround your email address.
> 
