Return-Path: <AymanE@tanisys.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [206.127.28.197])
	by ozlabs.org (Postfix) with ESMTP id 77260DE007
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 13:13:17 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Help enabling PCI endpoint on 460EX, host sees disabled
Date: Wed, 10 Dec 2008 20:13:15 -0600
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A0137F8AE@tanisys-ex2.Tanisys.Local>
In-Reply-To: <20081211001758.GA29190@ovro.caltech.edu>
From: "Ayman El-Khashab" <AymanE@tanisys.com>
To: "Ira Snyder" <iws@ovro.caltech.edu>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Ira Snyder [mailto:iws@ovro.caltech.edu]
> Sent: Wednesday, December 10, 2008 6:18 PM
> To: Ayman El-Khashab
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: Help enabling PCI endpoint on 460EX, host sees disabled
>=20
>=20
> I can't help you with that exact board, but I've written an "ethernet
> over PCI" driver for Linux and U-Boot. The Linux driver has=20
> been posted
> here on linuxppc-dev and on the lkml. Search for "net: add PCINet
> driver" and you'll find it.

Hello Ira, I am familiar with it, I looked through all of your posts and
the comments from RFCs 1-4.  That is what I was modeling mine after when
I ran across the "disabled" problem.  One thing I did not understand was
the device tree entries you made -- though that is unrelated to my=20
problem.
=20
> Definitely get PCI/PCI-E working and stable before you try to start
> communicating between the devices, though.

Thats my goal, there are a couple of things I am not sure about so I'm
sure I'll post again.
