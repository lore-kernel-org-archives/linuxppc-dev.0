Return-Path: <tmike@theptrgroup.com>
Received: from soulshock.mail.pas.earthlink.net
	(soulshock.mail.pas.earthlink.net [207.217.120.130])
	by ozlabs.org (Postfix) with ESMTP id 59AC72BDD3
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2004 07:42:04 +1000 (EST)
Received: from harrier.mail.pas.earthlink.net (harrier.mail.pas.earthlink.net
	[207.217.120.12])
	by soulshock.mail.pas.earthlink.net (8.11.6+Sun/8.11.6) with ESMTP id
	i8MKs2J11547
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2004 13:54:02 -0700 (PDT)
Received: from dpc6682045040.direcpc.com ([66.82.45.40] helo=tmtwin2kpro)
	by harrier.mail.pas.earthlink.net with smtp (Exim 3.33 #1)
	id 1CAE7a-0004Vx-00
	for linuxppc-dev@ozlabs.org; Wed, 22 Sep 2004 13:53:52 -0700
From: "T Michael Turney" <tmike@theptrgroup.com>
To: <linuxppc-dev@ozlabs.org>
Date: Wed, 22 Sep 2004 14:00:07 -0700
Message-ID: <GEEKLLHMFHLAJOBEEELHKEJJCLAA.tmike@theptrgroup.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: 2.4 kernel ppc-405 query
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Folks,
Most of my PPC experience is with Freescale pieces.

I have downloaded 2.4.26 from kernel.org as well
as 2.4.22 and the penguinppc patches for 2.4.22.

Currently working with penguinppc 2.4.22 on custom hardware.

Q.1) 405 platform seems more vulnerable to OOPS from config changes than
8xx?

General observation is the 405 code base seems more "fragile" than 8xx/8xxx
codebase.

Q.2) Is IDE internal workings different during discovery than FS accesses?

System can identify an IDE harddisk with 2 partitions but then generate
OOPS later on when attempting to mount /root filesystem.  I am suspecting
initial device setup including interrupt but don't want to waste time if
the discovery process indicates a fully-functional ide sub-system.

Cheers,
T.mike
