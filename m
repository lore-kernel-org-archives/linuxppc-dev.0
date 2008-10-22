Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 172CDDDEEB
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 09:12:15 +1100 (EST)
Subject: Re: Extended Addressing Mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <88C8EDEB-C9A5-4876-AF7D-55CBABBE111D@kernel.crashing.org>
References: <48FEEB88.6050505@kontron.com>
	<83735324-C37B-4C57-A50F-FFF0D133E4E3@kernel.crashing.org>
	<48FF23C4.5030408@kontron.com>
	<88C8EDEB-C9A5-4876-AF7D-55CBABBE111D@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 23 Oct 2008 09:11:46 +1100
Message-Id: <1224713506.7654.353.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
	=?ISO-8859-1?Q?R=E9gis_Odey=E9?= <regis.odeye@kontron.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-22 at 08:08 -0500, Kumar Gala wrote:
> > We are developing a board based on Freescale 8641D which can get
> 4GB  
> > of ram. So I need 4GB+IOs (~1GB) of physical addressing space.
> > My plan is to put a part of this ram above of 4GB to keep accesses  
> > to the IOs below the 4GB limit. It means non-contiguous ram  
> > addressing and XAEN features to be working.

Why would you put the IOs below the 4G point ? It's actually easier
to have the IOs up above, like a lot of 4xx do.

Cheers,
Ben.
