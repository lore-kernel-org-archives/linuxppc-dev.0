Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7194267A85
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 15:29:33 +1100 (EST)
Date: Tue, 22 Feb 2005 20:29:31 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050223042931.GB31255@gate.ebshome.net>
References: <c3d0340b050222190712ee7dff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b050222190712ee7dff@mail.gmail.com>
Cc: uboot <u-boot-users@lists.sourceforge.net>,
	ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: Ethernet doesn't work in linux for PPC440GP?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Feb 22, 2005 at 07:07:44PM -0800, Shawn Jin wrote:
> However with Uboot, the emac driver cannot read MAC addresses from VPD
> correctly. The original 2.6.10 code didn't recognize uboot's bd_info.

You are welcome to submit patch with U-Boot support for Ebony. 
Currently only OpenBIOS is supported. 

Look at the way it was done for Ocotea, 2.6 now supports both U-Boot 
and PIBS.

--
Eugene
