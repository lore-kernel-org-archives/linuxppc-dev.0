Return-Path: <rs@carriercomm.com>
Received: from ccomm-ex1.ccomm.com (unknown [207.158.3.3])
	by ozlabs.org (Postfix) with ESMTP id 93804DE008
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Apr 2008 03:23:55 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: JFFS2 root-fs
Date: Mon, 31 Mar 2008 10:23:53 -0700
Message-ID: <EE63F03D9E04774997AEBCD21FC77F251E9878@ccomm-ex1.ccomm.com>
From: "Sugathan, Rupesh" <rs@carriercomm.com>
To: "Georg Schardt" <g.schardt@fz-juelich.de>
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

=20
It seems to me, that the kernel does not find ANY file. because the
/dev/console file is in the image, but the initial console is not found
too

1) You should probably unpack and mount the jffs2 image on your host
directory to ensure that you see all files in place.=20
2) Check to see if your designated flash partition can hold all of your
jffs2 image.

Were you able to use the 'same' rootfs in any other way (nfs mount or
ramdisk) on the target?

Thanks
--
Rupesh Sugathan
