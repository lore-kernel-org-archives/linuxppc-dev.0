Return-Path: <Renaud.Barbier@ge.com>
Received: from ext-nj2gw-1.online-age.net (ext-nj2gw-1.online-age.net
	[216.35.73.163]) by ozlabs.org (Postfix) with ESMTP id DC8C967B62
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 02:08:45 +1000 (EST)
Received: from int-nj2gw-3.online-age.net (int-nj2gw-3 [3.159.236.67])
	by ext-nj2gw-1.online-age.net (8.12.9/8.12.9/990426-RLH) with ESMTP id
	j5FG8fwU007698 for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 12:08:42 -0400 (EDT)
Received: from cinmlef01.e2k.ad.ge.com (localhost [127.0.0.1])
	by int-nj2gw-3.online-age.net (8.12.9/8.12.8/990426-RLH) with ESMTP id
	j5FG8emQ012773 for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 12:08:41 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 15 Jun 2005 11:11:03 -0500
Message-ID: <45ABD2373C33C4459D42B40EC4F346F207E818A6@FTWMLVEM03.e2k.ad.ge.com>
From: "Barbier, Renaud \(GE Infrastructure\)" <Renaud.Barbier@ge.com>
To: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>,
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

thanks.=20
That was it. Too much dirt in my eyes today.
My U-boot script that builds the bootargs was wrong.

-----Original Message-----
From: Steven Blakeslee [mailto:BlakesleeS@embeddedplanet.com]
Sent: Wednesday, June 15, 2005 4:59 PM
To: Barbier, Renaud (GE Infrastructure); linuxppc-embedded@ozlabs.org
Subject: RE: Linux 2.4.26 boot over network


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
