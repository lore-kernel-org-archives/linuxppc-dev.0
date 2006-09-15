Return-Path: <Tom.Ziomek@motorola.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 9C254679E7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Sep 2006 02:11:49 +1000 (EST)
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (8.12.11/Motorola) with ESMTP id k8FGBlQR014872
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 09:11:47 -0700 (MST)
Received: from de01exm60.ds.mot.com (de01exm60.am.mot.com [10.176.8.105])
	by il06exr04.mot.com (8.13.1/8.13.0) with ESMTP id k8FGBlai008712
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 11:11:47 -0500 (CDT)
Date: Fri, 15 Sep 2006 11:11:46 -0500 (Central Daylight Time)
From: T Ziomek <ctz001@email.mot.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
In-Reply-To: <528646bc0609141549p319f01dfwb0d2897bb0bdc41f@mail.gmail.com>
Message-ID: <Pine.WNT.4.61.0609151059510.2448@holyoke.labs.mot.com>
References: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EA645@XSJ-EXCHVS1.xlnx.xilinx.com>
	<528646bc0609141549p319f01dfwb0d2897bb0bdc41f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: John Bonesio <john.bonesio@xilinx.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 14 Sep 2006, Grant Likely wrote:
  . . .
> - Stop requiring xparameters.h to be mangled!

Here, here!

>Generate it correctly
> the first time!  I think I'll scream if I get handed another xparams
> file from an FPGA engineer which was generated as a no-os target.  The
> Linux redefines are useful, why aren't they in xparameters.h for all
> targets?

I think that would be okay.  To offer an alternative, the way I handle
it now is to separate the two.  See
<http://ozlabs.org/pipermail/linuxppc-embedded/2005-August/019945.html>

Tom
-- 
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
