Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9ECAC67C24
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 10:28:41 +1100 (EST)
Received: from Jocke (84-217-94-167.tn.glocalnet.net [84.217.94.167])
	(authenticated bits=0)
	by dmz.lumentis.net (8.12.8/8.12.8) with ESMTP id kA6MmETI004076
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 23:48:18 +0100
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <linuxppc-dev@ozlabs.org>
Subject: mpc83xx_spi driver for mpc832x?
Date: Mon, 6 Nov 2006 23:48:09 +0100
Message-ID: <023401c701f5$a471b880$020120ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anyone working on extending the mpc83xx_spi driver to support
mpc832x? I don't think the current one supports either "cpu" mode
or "quicc" mode.

 Jocke
