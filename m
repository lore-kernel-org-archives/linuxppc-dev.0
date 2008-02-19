Return-Path: <rs@carriercomm.com>
Received: from ccomm-ex1.ccomm.com (unknown [207.158.3.3])
	by ozlabs.org (Postfix) with ESMTP id 472A7DDF71
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 05:04:51 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Frustrated question with insmod
Date: Tue, 19 Feb 2008 10:04:49 -0800
Message-ID: <EE63F03D9E04774997AEBCD21FC77F25190807@ccomm-ex1.ccomm.com>
From: "Sugathan, Rupesh" <rs@carriercomm.com>
To: <Bruce_Leonard@selinc.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> Bruce_Leonard@selinc.com wrote:
> > Sorry if this is the wrong place to post this question.  I'm
developing a=20
> > NAND flash driver and I need to do some detailed dubugging using GDB
with=20
> > a BDI2K.  According to the Denx web site, to find out the address=20
> > that
the=20
> > module is loading at you load it using the -m parameter to insmod
(i.e.,=20
> > "insmod -m mymodule").  However, every version of insmod I've tried=20
> > doesn't recognize ANY options much less -m.  Can anyone please point
me in=20
> > the right direction, or give me another way of knowing what the load

> > address of my module is?
>=20
> # cat /sys/module/<name>/sections/.text
>=20
> Do not forget to enable CONFIG_KALLSYMS.

Although this may not solve your problem, I once had to build insmod
with CONFIG_FEATURE_INSMOD_LOAD_MAP (this is not enabled by default)
option in its configuration to enable the -m option.

Thanks
..
Rupesh Sugathan
