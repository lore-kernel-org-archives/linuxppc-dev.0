Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6C73B6FBE
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2011 20:19:35 +1000 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	p5H9JmqK025574
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2011 11:19:48 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@ozlabs.org
Subject: Changes to of_device ?
Date: Fri, 17 Jun 2011 11:19:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201106171119.48178.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A couple linux versions ago, I had the following working code in my driver:

static int xad_driver_probe(struct of_device* dev, const struct of_device_id *match) {
	struct device_node *dn = dev->dev.of_node;

But now it won't compile and I can't figure out how to get the device_node structure from the of_device one ?
dev->dev is a struct device and there's no device_node info in it...
What has changed ?

[I'm on the latest Xilinx tree, FWIW, so that's 2.6.25 still ?]
-- 
Guillaume Dargaud
http://www.gdargaud.net/
