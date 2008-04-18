Return-Path: <Rick.Moleres@xilinx.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 32CB0DE311
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 02:15:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Xilinx network trouble (mostly solved)
Date: Fri, 18 Apr 2008 10:14:52 -0600
In-Reply-To: <04c001c8a162$242e7330$ad289e86@LPSC0173W>
References: <03fc01c8a072$67280110$ad289e86@LPSC0173W><20080417155609.9061E1D000B0@mail147-sin.bigfish.com>
	<04c001c8a162$242e7330$ad289e86@LPSC0173W>
From: "Rick Moleres" <Rick.Moleres@xilinx.com>
To: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>,
	<linuxppc-dev@ozlabs.org>
Message-Id: <20080418161454.E9E0C44009E@mail114-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Guillaume,

You might try v1.00a of the xps_ll_temac core.  There are a couple of
issues with v1.00b (posted previously on this list) that may (or may
not) be causing the problem you see.

-Rick

-----Original Message-----
From: linuxppc-dev-bounces+moleres=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-bounces+moleres=3Dxilinx.com@ozlabs.org] On Behalf =
Of
Guillaume Dargaud
Sent: Friday, April 18, 2008 8:40 AM
To: linuxppc-dev@ozlabs.org
Subject: Re: Xilinx network trouble (mostly solved)

Hello Rick,

> Which version of xps_ll_temac are you using, and which version of EDK?
Using xps 9.2.02i, build EDK_lm_SP2.3+0

IP version for the TriMode_MAC_GMII (xps_ll_temac) is 1.00.b. EmacLite
is=20
1.00.a

> Also, do both designs meet timing?
As the software guy here, I have no idea. I've passed the question onto
the=20
electronics guys...

BUT, you put me on the right tracks: looking at the driver versions I=20
started playing with the options you get in the [Configure IP] of the=20
Ethernet Mac drivers. I couldn't get any improvement with the LLTEMAC,
but=20
after I added the buffers to the EmacLite: IT WORKED !

I'm still having trouble mounting an NFS root and ssh'ing into the
target,=20
but I guess that's another issue...
--=20
Guillaume Dargaud
http://www.gdargaud.net/


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
