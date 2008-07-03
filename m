Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7839EDDE20
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 04:20:39 +1000 (EST)
Message-Id: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>,
	Laurent Pinchart <laurentp@cse-semaphore.com>,
	Jochen Friedrich <jochen@scram.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: New fsl device bindings file
Date: Thu, 3 Jul 2008 13:20:18 -0500
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guys,

I'm sure you'll hate for doing this, but I've asked Kim to create a  
new Documentation/powerpc/fsl-device-tree-bindings.txt as part of his  
SEC patch.

I'm going to move all the Freescale SoC related bindings into this new  
file.  One of the aspects of the new file is we will NOT having an  
ordinal heading index.

Once I accept his new patch that add bindings to the new file.

thanks

- k
