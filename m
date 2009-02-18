Return-Path: <scott.coulter@cyclone.com>
Received: from CYBORG3.cyclone.com (cyborg3.cyclone.com [69.37.28.78])
	by ozlabs.org (Postfix) with ESMTP id 2C634DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 03:16:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Gianfar tx-babbling-errors
Date: Wed, 18 Feb 2009 11:16:11 -0500
Message-ID: <43EB80E07C42E1408726E4905FB96B04C0769D@CYBORG3.cyclone.com>
From: "Scott Coulter" <scott.coulter@cyclone.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi all,

As a simple stress test for my board with an MPC8572E and an MPC8568E on
it, I setup both processors to boot linux 2.6.27.6 with an NFS root and
then perform repeated native compiles of a linux kernel over NFS.  After
running for 4 days straight or so with between 250-300 build cycles per
processor, I stopped the builds and ran ethtool to look for any odd
statistics.  Both processors reported non-zero values for
tx-babbling-errors.  Both processors reported around 1300
tx-babbling-errors out of about 80,000,000 Tx packets.  Should I be
concerned about the tx-babbling-errors?  What conditions would cause
these errors to be reported?

Thanks,
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
