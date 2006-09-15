Return-Path: <john.bonesio@xilinx.com>
Received: from outbound1-ash-R.bigfish.com (outbound-ash.frontbridge.com
	[206.16.192.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 867C667B6A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Sep 2006 05:40:25 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Ethernet driver for Linux kernel 2.6 running on ML403
Date: Fri, 15 Sep 2006 12:13:55 -0700
Message-ID: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EAC01@XSJ-EXCHVS1.xlnx.xilinx.com>
From: "John Bonesio" <john.bonesio@xilinx.com>
To: "Keith J Outwater" <kjoutwater@raytheon.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Keith,

I know that on the surface it seems like a simple thing. Some of our
parts are big, yet some are small. We are always getting pressure to
make our IP as small as possible.

Though, this may be something we can revisit again, for now this
information just isn't going to be available.

Perhaps the problem can be solved in a different way.

- John

-----Original Message-----
From: linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org] On
Behalf Of Keith J Outwater
Sent: Thursday, September 14, 2006 5:09 PM
To: linuxppc-embedded@ozlabs.org
Subject: RE: Ethernet driver for Linux kernel 2.6 running on ML403

"John Bonesio" <john.bonesio@xilinx.com> wrote on 09/14/2006 10:52:16
AM:
<snip>
>=20
> I don't think that there are any "version" registers in the Xilinx=20
> IP cores that a driver could check to determine compatibility.  That
> would be very cheap to implement in hardware and you could then
> develop more universal drivers.
>=20
> [John]
> We've examined doing this in the past, and gotten some push back due
to
> the use of bram or other resources. Conceptually, it's a great idea, I
> just don't know if this is likely to happen any time soon.
>=20

John,
I thinking in terms of something like a 32 bit register
(i.e. like a processor's PVR register) that has a hard-coded magic
number
which a driver can read and decode to determine driver compatibility.
That does not sound resource-intensive given the size FPGAs we are
talking
about.  Probably don't even need 32 bits.

Keith
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
