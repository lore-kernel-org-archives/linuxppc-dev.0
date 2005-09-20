Return-Path: <eli.brin@rokonet.co.il>
Received: from rokonet-e.ROKONET_TREE.LOCAL (unknown [192.114.177.4])
	by ozlabs.org (Postfix) with ESMTP id 914B66830C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 05:24:31 +1000 (EST)
Message-ID: <023EF71CB65AA949A2C510353690C86B5BF2C3@rokonet-e.rokonet_tree.local>
From: Eli Brin <eli.brin@rokonet.co.il>
To: David Jander <david.jander@protonic.nl>
Date: Tue, 20 Sep 2005 22:25:33 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Which way to store log in flash on mpc8xx? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello David,

Wolfgang wrote:
>Yes, there is. Run the system with root file system mounted over NFS,
>and then put some load on the system, like  by  compiling  the  linux
>kernel  on  the  target.

If you want to have some fun, and stress the platform, compile and run (via
NFS) Crafty, an open source Linux chess porgram.

We did so on our 8xx target and it plays very well...

Best regards,
Eli Brin
