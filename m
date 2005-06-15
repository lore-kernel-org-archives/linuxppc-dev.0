Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from tag-03.ashton-group.com (tag-03.ashton-group.com [66.94.86.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31FA167B5A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 01:59:11 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 15 Jun 2005 11:59:05 -0400
Message-ID: <1628E43D99629C46988BE46087A3FBB92858F3@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: "Barbier, Renaud \(GE Infrastructure\)" <Renaud.Barbier@ge.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: Linux 2.4.26 boot over network
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>Now, I am trying to boot Linux over the network using the following
boot arguments:
>Kernel command line: console=3DttyS0,9600n8 console=3Dtty0 =
root=3D/dev/nfs rw
nfsroot=3D
>192.168.49.189:/home/proj/at921/Filesys/usr/local/gefnes/target
>192.168.49.1:192.168.49.189::255.255.255.0::eth0:off da104_gpio=3D8

In the first one you had ip=3Dbootp, this uses bootp to get the ip
address.  In the second one you do not have an ip define so the ethernet
is not being enabled.  You need something like this
ip=3D192.168.49.1:::255.255.255.0
