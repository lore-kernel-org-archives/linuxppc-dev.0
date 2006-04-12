Return-Path: <rick.moleres@xilinx.com>
Received: from outbound2-res-R.bigfish.com (outbound-res.frontbridge.com
	[63.161.60.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2C59167CE9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Apr 2006 08:29:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: question about Linux 2.6 with Xilinx ML-403
Date: Wed, 12 Apr 2006 15:54:47 -0600
Message-ID: <689CB232690D8D4E97DA6C76DA098E6C021E5AAA@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Rick Moleres" <rick.moleres@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Martin, Tim" <tim.martin@viasat.com>
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


Yes, we have a driver for the PLB TEMAC (different than the GSRD LL
TEMAC) for Linux 2.4 (MontaVista Linux 2.4.20) that's shipped in EDK
8.1.1, and MontaVista is on the verge of publishing a driver for PLB
TEMAC for Linux 2.6. (I believe it came across this mailing list a few
weeks ago)

-Rick

-----Original Message-----
From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On
Behalf Of Grant Likely
Sent: Wednesday, April 12, 2006 3:25 PM
To: Martin, Tim
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: question about Linux 2.6 with Xilinx ML-403

On 4/12/06, Martin, Tim <tim.martin@viasat.com> wrote:
>
> Which 2.4 driver - there's the "Montavista" one for the softcore PLB
> EMAC, and there's also one for the hardcore PLB TEMAC that gets
> distributed with the GSRD.

The montavista softcore driver.  Has someone written a driver for the
TEMAC yet?

g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 399-0195
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
