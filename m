Return-Path: <chang.sun@xilinx.com>
Received: from outbound1-ash-R.bigfish.com (outbound-ash.frontbridge.com
	[206.16.192.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9B657679EB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Apr 2006 05:29:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: question about Linux 2.6 with Xilinx ML-403
Date: Sun, 23 Apr 2006 12:00:57 -0700
Message-ID: <0AF7A30943B8EF42B5A41B51B30BE52C0197306B@XSJ-EXCHVS1.xlnx.xilinx.com>
From: "Chang Sun" <chang.sun@xilinx.com>
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

Grant,=20
I checked both Torvalds' tree and Paul's tree. I see the defconfig file
for both ml300 and ml403, but I don't see any source files related to
either ml300 or ml403 under the <platforms> subdirectory. Have you done
a complete BSP for either ml300 or ml403?

Thanks,=20
Chang

-----Original Message-----
From: linuxppc-embedded-bounces+chang.sun=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+chang.sun=3Dxilinx.com@ozlabs.org] On
Behalf Of Grant Likely
Sent: Wednesday, April 12, 2006 11:45 AM
To: Martin, Tim
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: question about Linux 2.6 with Xilinx ML-403

On 4/12/06, Martin, Tim <tim.martin@viasat.com> wrote:
> Grant,
>
> I know I could probably figure this out by looking at the GIT tree
> directly (which I'm planning to do) but could you summarize how much
> (which devices) of the ML-403 is supported by your patches?
>
> Serial? (which Xilinx core)
Yes, full uart

>
> Ethernet? (Hard-Core PLB TEMAC?, Soft-Core PLB EMAC? Localink TEMAC?
Is
> 10/100/1000 supported, or is there only 1 rate e.g. 1000 supported?)

No.  I've ported the 2.4 driver, but I haven't got permission to
release it yet.  (I'm a contractor; I don't own any of the work I do)

>
> Anything else (GPIO buttons/switches?)
I've got drivers for the PS/2 & VGA, but I'm still trying to get them
released.

Cheers,
g.
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
