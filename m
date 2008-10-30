Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id A94AFDDDF5
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 22:00:07 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by comm-neu.esd (Postfix) with ESMTP id 4873010804A
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 11:58:55 +0100 (CET)
Received: from comm-neu.esd ([127.0.0.1])
	by localhost (comm [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 23501-03-2 for <linuxppc-dev@ozlabs.org>;
	Thu, 30 Oct 2008 11:58:49 +0100 (CET)
Received: from debby.esd (debby.esd [10.0.0.190])
	by comm-neu.esd (Postfix) with ESMTP id ED949108046
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 11:58:49 +0100 (CET)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org
Subject: Connecting to "PCI command write" interrupt on 4xx platforms
Date: Thu, 30 Oct 2008 11:58:46 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810301158.46686.matthias.fuchs@esd-electronics.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I need to connect to the "PCI command write" interrupt on a 440EPx platform. This is UIC0/int#5.

Where should I add this interrupt in the DT? To the PCI node? In this case it will collide with the 
PCI interrupts.

My application is a 440EPx on a PCI addon card. So the PCI node is disabled in the DT.

Is there a way to get an interrupt number for request_irq() without querying the DT?

Matthias
