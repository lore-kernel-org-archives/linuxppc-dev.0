Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DD363B7CE2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Mar 2010 04:13:41 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o2NHDMeh024261 for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Mar 2010 10:13:32 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o2NHKdi2008793
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Mar 2010 12:20:39 -0500 (CDT)
Date: Tue, 23 Mar 2010 12:13:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: liu.yaojin@zte.com.cn
Subject: Re: The GPIO problem on MPC8323?
Message-ID: <20100323171321.GA27601@b07421-ec1.am.freescale.net>
References: <OFAA998E02.C84A631E-ON482576EF.00270F1D-482576EF.00279F48@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFAA998E02.C84A631E-ON482576EF.00270F1D-482576EF.00279F48@zte.com.cn>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 23, 2010 at 03:07:49PM +0800, liu.yaojin@zte.com.cn wrote:
> hi,all:
> 
> i saw peter's mpc8xxx_gpio.c in kernel 2.6.31. it seems that file can only 
> be used on 831x and others, but not mpc8323. my platform is mpc8323, how 
> can i use the GPIO?
> i also found "QE GPIO Support" and "Support for simple, memory-mapped GPIO 
> controllers" selection,  how can i use it and test in user space?
> 
> thanks, best regards.

This is the same e-mail that you sent yesterday...  Yes, you want the QE
GPIO driver for QE chips.  It should work the same as other GPIO drivers. 
Check the documentation or the code for how to use the interface.

-Scott
