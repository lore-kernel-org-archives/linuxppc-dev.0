Return-Path: <susheel.nuguru@mitron.fi>
Received: from mitron.mitron.fi (mail.mitron.fi [82.116.252.3])
	by ozlabs.org (Postfix) with ESMTP id 016BA67F73
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Aug 2005 22:08:16 +1000 (EST)
From: Nuguru Susheel <susheel.nuguru@mitron.fi>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 17 Aug 2005 15:11:05 +0000
Message-Id: <1124291465.13335.62.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Sylvain Munaut <tnt@246tNt.com>
Subject: Bestcomm and FEC problems in 2.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

  I know that very few are now using MPC5200 Rev B, even then i dare
that someone would answer me :-)...

  Root NFS doesnt work for me on this core and i was suggested that I
should use new Bestcomm drivers from Sylvain's 2.6 kernel (I think I
would need both Bestcomm and FEC drivers).. I am also aware of Andrey
Volkov's updates of the Bestcomm drivers but, I am using Denx 2.4
Version. 

  does anyone tried to use this new drivers into 2.4 kernel. If yes
please give me a hint how to do so, because of difference in the file
structure of the these versions the solution is definately not straight
forward and needs a lot of hacking ...

any suggestions where to start ???

thanks a lot,
   nSr
