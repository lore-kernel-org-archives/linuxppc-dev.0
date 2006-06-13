Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B790067B37
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 02:07:32 +1000 (EST)
Received: from p54b0d4a3.dip.t-dialin.net ([84.176.212.163] helo=yukito)
	by mail.genesippc.com with esmtpa (Exim 4.62 (FreeBSD))
	(envelope-from <matt@genesi-usa.com>) id 1FqAjI-000C6f-Ba
	for linuxppc-dev@ozlabs.org; Tue, 13 Jun 2006 15:22:56 +0000
From: "Matt Sealey" <matt@genesi-usa.com>
To: <linuxppc-dev@ozlabs.org>
Subject: OpenFirmware framebuffer
Date: Tue, 13 Jun 2006 10:26:22 -0500
Message-ID: <021501c68efd$bc311080$99dfdfdf@bakuhatsu.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Reply-To: matt@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I just booted up my Pegasos and tried the offb driver for display and was
rather disappointed. It just displays 4 lines about HID0 and stuff and then
waits around.

Is this all there is? Is there nothing more? Can't I get a scrolling kernel
output, and a penguin logo or am I missing the point? :)

-- 
Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations
