Return-Path: <edjubenville@adelphia.net>
Received: from mta11.adelphia.net (mta11.adelphia.net [68.168.78.205])
	by ozlabs.org (Postfix) with ESMTP id D6FDC67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 06:57:26 +1000 (EST)
Received: from EJ1 ([69.166.195.214]) by mta11.adelphia.net
	(InterMail vM.6.01.04.01 201-2131-118-101-20041129) with SMTP
	id <20050330205724.JCFI5402.mta11.adelphia.net@EJ1>
	for <linuxppc-embedded@ozlabs.org>; Wed, 30 Mar 2005 15:57:24 -0500
From: "Edward Jubenville" <edjubenville@adelphia.net>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 30 Mar 2005 12:57:23 -0800
Message-ID: <GPECLCIGPLHEOMGPMCPAOEOJCMAA.edjubenville@adelphia.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: USB support on Lite5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm using a FreeScale Lite5200 development board with an MPC5200.  I used
ELDK 1.3 and DAS U-Boot to get a working kernel, booted, etc., but I later
found that the configuration I chose (icecube_5200_defconfig) didn't have
USB support enabled.

My first USB goal is hook up a SanDisk cruzer 256 MB memory stick.  Which
configuration options need to change?  Is there a HOWTO or example
configuration file somewhere?

Eventually, I would like to support at least one kind of USB keyboard.
Where can I find guidance for that configuration.

If there's a better place to post these questions, please advise.

Thanks in advance,
Ed
