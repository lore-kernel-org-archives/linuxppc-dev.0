Return-Path: <cpclark@2nerds.com>
Received: from mgr2.xmission.com (mgr2.xmission.com [198.60.22.202])
	by ozlabs.org (Postfix) with ESMTP id F01AE67A72
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Feb 2005 08:55:08 +1100 (EST)
Date: Fri, 18 Feb 2005 12:28:43 -0700 (MST)
From: cpclark@2nerds.com
To: Grant Likely <glikely@gmail.com>
In-Reply-To: <20050218172039.GA14098@xyzzy>
Message-ID: <Pine.LNX.4.62.0502181221410.25145@xmission.xmission.com>
References: <528646bc05021515486bd9f926@mail.gmail.com>
	<4213B111.4050905@246tNt.com>
	<528646bc05021714135dcb1d01@mail.gmail.com>
	<528646bc05021714356238ff35@mail.gmail.com>
	<20050218172039.GA14098@xyzzy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200 full duplex support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 18 Feb 2005, Dale Farnsworth wrote:
> There is currently no mechanism for the driver to detect if the PHY
> negotiated full or half duplex.

You may want to take a look at arch/ppc/5xxx_io/fec.[ch] in the denx.de 
linuxppc_2_4_devel CVS tree (particularly cvs revisions 1.4 and 1.10 of 
fec.c and revisions 1.5 and 1.6 of fec.h).

Chris
