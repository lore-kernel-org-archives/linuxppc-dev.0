Return-Path: <jakob.viketoft@bitsim.se>
Received: from amsfep20-int.chello.nl (amsfep20-int.chello.nl [213.46.243.18])
	by ozlabs.org (Postfix) with ESMTP id 9EC2267A64
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 18:00:07 +1000 (EST)
Message-ID: <424A5C89.2030504@bitsim.se>
Date: Wed, 30 Mar 2005 10:00:09 +0200
From: Jakob Viketoft <jakob.viketoft@bitsim.se>
MIME-Version: 1.0
To: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Platform bus/ppc sys model...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello everyone!

This is a mail I sent to Kumar Gala, but as he rightly pointed out that 
more people might benefit from the information and contribute to it, I 
send it to the list instead.

Is there some good documentation about how to use the platform bus / ppc
sys model or is it only possible to read and try to understand the code
for the freescale devices?

Specifically, how do you make the kernel aware of a certain device and
what else is required? Do I have to "connect" the device and the driver
or will the new model find this out automagically? I'm looking at adding 
the usual serials, emacs etc...

Lastly, I suppose this will be the way all platforms should connect
their boards with the devices "from now on", right?

Cheers!

	/Jakob
