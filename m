Return-Path: <scott.coulter@cyclone.com>
Received: from CYBORG3.cyclone.com (cyborg3.cyclone.com [69.37.28.78])
	by ozlabs.org (Postfix) with ESMTP id 09792DDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 03:38:06 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Gianfar tx-babbling-errors
Date: Thu, 19 Feb 2009 11:38:04 -0500
Message-ID: <43EB80E07C42E1408726E4905FB96B04C07702@CYBORG3.cyclone.com>
In-Reply-To: <A543F487-78F9-4791-ABEB-2D8D017A516B@kernel.crashing.org>
References: <43EB80E07C42E1408726E4905FB96B04C0769D@CYBORG3.cyclone.com>
	<F122E3A2-3054-4BC9-9C06-0ADE590A8AFC@kernel.crashing.org>
	<43EB80E07C42E1408726E4905FB96B04C076B1@CYBORG3.cyclone.com>
	<6BBF4AB4-FFB0-46ED-B591-17DEC3BE547F@kernel.crashing.org>
	<43EB80E07C42E1408726E4905FB96B04C07700@CYBORG3.cyclone.com>
	<A543F487-78F9-4791-ABEB-2D8D017A516B@kernel.crashing.org>
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


>=20
> What specific processor & rev are you running on?
>

I've only been running the modified kernel with the added BUG_ON() code
on the 8568E processor, but I've seen the errors reported on the 8572E
as well.

According to the u-boot startup:

8568E, Version: 1.1, (0x807d0011)
Core:  E500, Version: 2.2 (0x80210022)

8572E, Version: 1.1, (0x80e80011)
Core:  E500, Version: 3.0 (0x80210030)


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
