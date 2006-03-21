Return-Path: <hollis@penguinppc.org>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7265867A5C
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 13:55:39 +1100 (EST)
Received: from e31.co.us.ibm.com (e31.boulder.ibm.com [9.17.249.41])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id k2L2FCes004246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 21:15:13 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2L2F8SB004423
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 21:15:08 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2L2I6wu124536
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:18:08 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2L2F6uO025198
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:15:06 -0700
From: Hollis Blanchard <hollis@penguinppc.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Add FSL SEC node to documentation
Date: Mon, 20 Mar 2006 20:14:43 -0600
References: <20060320195945.004fdf26.kim.phillips@freescale.com>
In-Reply-To: <20060320195945.004fdf26.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603202014.44879.hollis@penguinppc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 20 March 2006 19:59, Kim Phillips wrote:
> diff --git a/Documentation/powerpc/booting-without-of.txt=20
b/Documentation/powerpc/booting-without-of.txt
> index d02c649..72f3241 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1365,6 +1365,79 @@ platforms are moved over to use the flat
> =A0=A0=A0=A0=A0=A0};
> =A0
> =A0
> + =A0 g) Freescale SOC SEC Security Engines
> +
> + =A0 Required properties:
> +
> + =A0 =A0- device_type : Should be "crypto"
> + =A0 =A0- model : Model of the device. =A0Should be "SEC1" or "SEC2"
> + =A0 =A0- compatible : Should be "talitos"
[snip]

Have you consulted with any other vendors regarding these properties? I kno=
w=20
there is no IEEE1275 binding for these sorts of devices, but we can at leas=
t=20
attempt to standardize it (even in the absence of the Open Firmware Working=
=20
Group)...

=2DHollis
