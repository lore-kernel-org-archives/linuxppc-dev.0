Return-Path: <uzurpatorul@yahoo.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CCDABB7084
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 05:07:08 +1000 (EST)
Received: from web30308.mail.mud.yahoo.com (web30308.mail.mud.yahoo.com
	[209.191.69.70]) by ozlabs.org (Postfix) with SMTP id 2779ADDDE2
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 05:07:07 +1000 (EST)
Message-ID: <334139.60682.qm@web30308.mail.mud.yahoo.com>
Date: Mon, 13 Jul 2009 12:00:26 -0700 (PDT)
From: Robert Benea <uzurpatorul@yahoo.com>
Subject: vmalloc issue on mpc8378
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1925117692-1247511626=:60682"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--0-1925117692-1247511626=:60682
Content-Type: text/plain; charset=us-ascii

I have an mpc8378 system with 512MB ram and 256MB flash (NOR). When I start the system I get the infamous message vmalloc failure. If I do cat /proc/meminfo I can see that I have only 212MB of VMALLOC space. 

I tried the advanced options and change the KERNEL_START to 0xb0000000 (instead of 0xc0000000), however after doing that the system became unstable with crashes left and right. 

The current work around is to set the command line mem=400M, however I like to use the whole RAM. What are the possible culprits that made my system unstable when making the KERNEL address space larger ?. Can it be because of PCIEs devices, I see that the PCIE memory is mapped to 0xa000000/0xc0000000.

Regards,
R.




      
--0-1925117692-1247511626=:60682
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;">I have an mpc8378 system with 512MB ram and 256MB flash (NOR). When I start the system I get the infamous message vmalloc failure. If I do cat /proc/meminfo I can see that I have only 212MB of VMALLOC space. <br><br>I tried the advanced options and change the KERNEL_START to 0xb0000000 (instead of 0xc0000000), however after doing that the system became unstable with crashes left and right. <br><br>The current work around is to set the command line mem=400M, however I like to use the whole RAM. What are the possible culprits that made my system unstable when making the KERNEL address space larger ?. Can it be because of PCIEs devices, I see that the PCIE memory is mapped to 0xa000000/0xc0000000.<br><br>Regards,<br>R.<br><br></td></tr></table><br>

      
--0-1925117692-1247511626=:60682--
