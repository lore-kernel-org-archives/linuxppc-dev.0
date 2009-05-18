Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 732F1DDFF2
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 03:10:50 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4IHATUJ021269
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 10:10:42 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n4IHASkO000858
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 12:10:28 -0500 (CDT)
Date: Mon, 18 May 2009 12:10:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: Chris Plasun <chrispl78@yahoo.com>
Subject: Re: Accessing NTFS Shares from Freescale MPC8313
Message-ID: <20090518171028.GA18620@b07421-ec1.am.freescale.net>
References: <4A0FCEAA.5000606@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A0FCEAA.5000606@yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 17, 2009 at 01:45:30AM -0700, Chris Plasun wrote:
> Hi,
> 
> (I haven't found any answers in the archives)
> 
> How would I access a NTFS shared directory from a Freescale MPC8313?
> 
> Will Samba run on a Freescale MPC8313?

It should (and if it doesn't, file a bug with them).  

Userspace is pretty much the same at the source-code and user-interface
level -- the answer to "how do I do X on this PPC board" is generally the
same as the answer to "how do I do X on Linux", other than that you may
need to compile some packages manually if they don't come with whatever
distribution you're using.

-Scott
