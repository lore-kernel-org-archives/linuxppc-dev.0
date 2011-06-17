Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 034DBB6FBA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 23:53:11 +1000 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	p5HDr6h5031505
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2011 15:53:06 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Changes to of_device ?
Date: Fri, 17 Jun 2011 15:53:06 +0200
References: <201106171119.48178.dargaud@lpsc.in2p3.fr>
	<4DFB4F51.1090509@gate-nine.de> <4DFB516C.4060602@gate-nine.de>
In-Reply-To: <4DFB516C.4060602@gate-nine.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106171553.06443.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I'm sorry, I should have mentioned that struct of_device was replaced by
> struct platform_device. So in order to get your code compiled, you have
> to change the probe function to
> 
> static int xad_driver_probe(struct platform_device* dev, const struct
> of_device_id *match) {

Thanks, that worked...

Side question: how do you guy find your way inside the kernel ? I spent hours trying to find the declarations of various 
basic structs like device, of_node, etc even with ack-grep and ctags (which I probably don't know how to use very well).
-- 
Guillaume Dargaud
http://www.gdargaud.net/
