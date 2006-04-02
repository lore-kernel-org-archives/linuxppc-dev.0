Return-Path: <biteme@quicknet.nl>
Received: from mx101.multikabel.net (mx101.multikabel.net [212.127.254.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D4CA679F5
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Apr 2006 00:30:20 +1000 (EST)
Received: from vmx20.multikabel.net ([212.127.254.137])
	by mx101.multikabel.net with esmtp (Exim 4.54) id 1FQ2ry-0008VF-Ax
	for linuxppc-dev@ozlabs.org; Sun, 02 Apr 2006 15:43:54 +0200
Received: from sun.nodomain.nl (84-104-186-89.cable.quicknet.nl
	[84.104.186.89])
	by vmx20.multikabel.net (8.13.6/8.13.3) with ESMTP id k32Di0m2027808
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Apr 2006 15:44:07 +0200
From: "Ingmar" <biteme@quicknet.nl>
To: linuxppc-dev@ozlabs.org
Subject: yaboot load address
Date: Sun, 2 Apr 2006 15:43:59 +0200
Message-Id: <20060402134229.M44328@quicknet.nl>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I have a issue with the load address of the yaboot loader, I need it to be
loaded higher in memory than 2MB, at about 10MB. Recompiling the yaboot loader
is no problem, but I need to get into the part of code that calls (and loads)
the yaboot program. Editing the ofboot file, (forth script) does not
(completely?) solve the problem. Updates to the ToolBox ROM image have to be
made to?

Any ideas on steps I need to make to (recompile?) edit the tbxi file to let it
load yaboot at another address?


Ingmar
