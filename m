Return-Path: <SWarren@nvidia.com>
Received: from HQEMGATE01.nvidia.com (hqemgate01.nvidia.com [216.228.112.170])
	by ozlabs.org (Postfix) with ESMTP id 837AE67A78
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 06:09:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Tue, 8 Mar 2005 11:09:40 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0056A92CC@hqemmail02.nvidia.com>
From: "Stephen Warren" <SWarren@nvidia.com>
To: "Dale Farnsworth" <dale@farnsworth.org>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: MPC5200 kernel with IDE *and* FEC?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Dale Farnsworth [mailto:dale@farnsworth.org]=20
> On Tue, Mar 08, 2005 at 05:34:20PM +0000, Stephen Warren wrote:
> > I looked at the 2.6.11 kernel.org kernel, and it has MPC5200 IDE
> > support, but apparently no FEC driver support.
>=20
> Are you sure it has MPC5200 IDE support?  I have yet to see reliable
> 5200 IDE support and haven't seen a 5200 IDE driver for 2.6 at all.

Not sure, no. Looking at "xconfig", I don't see an option for it. A
colleague said it did.

We've used IDE (for a DVD-ROM) using the Denx kernel. This didn't have
DMA suppport, but Freescale gave us a derivate kernel that it, which
seemed to work well. They said they were going to push this up through
Denx into the main kernel. Didn't they bother to do this?

> I did the FEC driver in Sylvain's tree.  He has promised to push
> it to kernel.org RSN.

That'd be great.

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html
