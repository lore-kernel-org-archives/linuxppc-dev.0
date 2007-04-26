Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 942FFDDF67
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 08:02:43 +1000 (EST)
Received: from 82-46-178-156.cable.ubr06.king.blueyonder.co.uk
	([82.46.178.156] helo=[192.168.2.228])
	by mail.genesi-usa.com with esmtpa (Exim 4.66 (FreeBSD))
	(envelope-from <matt@genesi-usa.com>) id 1HhBpS-000Emw-Ey
	for linuxppc-dev@ozlabs.org; Thu, 26 Apr 2007 21:48:42 +0000
Message-ID: <46312196.10806@genesi-usa.com>
Date: Thu, 26 Apr 2007 23:03:02 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: DMA controllers (about IOAT vs. BestComm)
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Quickie question, has anyone from the PPC team looked at the work Intel have
done on the generic DMA engine interface and their IOAT driver?

How does it fare for the possibility of adding common PPC DMA controllers
(52xx BestComm, PowerQUICC II/III, MV63xx, Tsi10x..) for the very basic
memcpy style offloads, not to mention the networking stack, any XOR
engines present and so on?

Or did they make it a little too x86-specific?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
