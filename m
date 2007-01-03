Return-Path: <mcr@sandelman.ottawa.on.ca>
Received: from cod.sandelman.ca (cod.sandelman.ca [192.139.46.42])
	by ozlabs.org (Postfix) with ESMTP id 47CE7DDEC0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Jan 2007 04:16:54 +1100 (EST)
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
To: n.balaji@gdatech.co.in
Subject: Re: Asynchronous Crypto suppor for MPC8360E's Security Engine 
In-Reply-To: Message from n.balaji@gdatech.co.in of "Wed,
	03 Jan 2007 16:38:02 +0530."
	<5380.202.144.30.226.1167822482.squirrel@mail.gdatech.co.in>
References: <5380.202.144.30.226.1167822482.squirrel@mail.gdatech.co.in> 
Date: Wed, 03 Jan 2007 11:43:37 -0500
Message-ID: <9722.1167842617@sandelman.ottawa.on.ca>
Sender: mcr@sandelman.ottawa.on.ca
Cc: linuxppc-embedded@ozlabs.org, ilugc@ae.iitm.ac.in
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>>>>> "n" == n balaji <n.balaji@gdatech.co.in> writes:
    n> Hi, I am working on MPC8360E Security Engine. I have ported the
    n> Openswan 2.4.5(IPSec --KLIPS) with OCF to MPC8360E's Security
    n> Engine (Talitos).  Encryption and Decryption is working. But when

  You don't say if you ported OCF from sf.net, or from the OCF git tree
on http://hifn.xelerance.com/

  The latter is based upon 2.6.18 kernel, so perhaps not.

  There have been numerous improvements in the past 4 months to OCF, but
we are still not seeing multiple packets being submitted to the hardware
driver layer from OCF. As such, the hardware's pipeline is not being
kept full.

- -- 
]            Bear: "Me, I'm just the shape of a bear."          |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Finger me for keys

iQEVAwUBRZvdOICLcPvd0N1lAQI4RwgAkW6qZVOmEXLGMM1g6h3TgzCfhKPb+0/I
vlH2OHIlmC46wRQvpeH0VKGTWU3s/4j1076lgVRhK1NHVILjMKeaRLa6EQn7+sI3
Hvc1afEI3wIw0dLNNSgAPkDC95rrcW12OpPe7jGmZdvuR+ATlx2AX4pQ7xS1Rzol
0nPHta4ickgC6ZuAGicUVzgrU2lVfB1aHmcjDAKm0GWyzGB6rpp3/5daJXSZBOgS
gHOvGswTPYCLCq88pmpXS4ihU8DZNEV97lEJ4/J9V4V0D/0WvyKGo584mBOi7OJK
wUPaOjq/IZlJWz4XVeM2NNeNmn5ttlyNYdHX3HkG109U3+go5hatXQ==
=8CC2
-----END PGP SIGNATURE-----
