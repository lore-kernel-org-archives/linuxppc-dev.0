Return-Path: <joakim.tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA2812BDA2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Oct 2004 01:17:52 +1000 (EST)
Received: from jockewin (fw [172.31.1.1]) (authenticated bits=0)
	by dmz.lumentis.net (8.12.8/8.12.8) with ESMTP id i9EEru7H030304
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Thu, 14 Oct 2004 16:53:56 +0200
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 14 Oct 2004 16:53:49 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEEIEEPCNAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Merge 8xx to Linus tree?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Is it not time to merge 8xx from linuxppc-2.5 into Linus tree?

I know the 8xx is not fully functional yet but this isn't done
soon I think it won't happen at all. The 8xx arch can be made to 
depend on BROKEN in Linus tree to make it clear that it isn't
working properly yet.

  Jocke
