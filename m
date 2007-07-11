Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9C67EDDECA
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 04:05:29 +1000 (EST)
Received: from 82-46-178-156.cable.ubr06.king.blueyonder.co.uk
	([82.46.178.156] helo=[192.168.2.228])
	by mail.genesi-usa.com with esmtpa (Exim 4.66 (FreeBSD))
	(envelope-from <matt@genesi-usa.com>) id 1I8gJ9-000MXQ-2q
	for linuxppc-dev@ozlabs.org; Wed, 11 Jul 2007 17:48:59 +0000
Message-ID: <46951C1A.4080001@genesi-usa.com>
Date: Wed, 11 Jul 2007 19:06:18 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Tickless Hz/hrtimers/etc. on PowerPC
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Does anyone have the definitive patchset to enable the tickless hz,
some kind of hrtimer and the other related improvements in the
PowerPC tree?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
