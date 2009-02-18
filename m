Return-Path: <scott.coulter@cyclone.com>
Received: from CYBORG3.cyclone.com (cyborg3.cyclone.com [69.37.28.78])
	by ozlabs.org (Postfix) with ESMTP id 2D4A7DDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 04:22:04 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Gianfar tx-babbling-errors
Date: Wed, 18 Feb 2009 12:22:02 -0500
Message-ID: <43EB80E07C42E1408726E4905FB96B04C076B1@CYBORG3.cyclone.com>
In-Reply-To: <F122E3A2-3054-4BC9-9C06-0ADE590A8AFC@kernel.crashing.org>
References: <43EB80E07C42E1408726E4905FB96B04C0769D@CYBORG3.cyclone.com>
	<F122E3A2-3054-4BC9-9C06-0ADE590A8AFC@kernel.crashing.org>
From: "Scott Coulter" <scott.coulter@cyclone.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar,

> I'm told this will occur when:

> Transmitted frame > MAXFRM and MACCFG2[Huge En] =3D 0.

In the driver it looks like the MACCFG2_HUGEFRAME only gets set if the
mtu > DEFAULT_RX_BUFFER_SIZE (1536 in my kernel).  It appears as though
the mtu is set to 1500.  Under what conditions would the driver attempt
to send a frame larger than the mtu?

Scott

___________________________________________________________________

  Scott N. Coulter
  Senior Software Engineer
 =20
  Cyclone Microsystems         =20
  370 James Street              Phone:  203.786.5536 ext. 118
  New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com
  U.S.A.                        Web:    http://www.cyclone.com
___________________________________________________________________
