Return-Path: <jakob.viketoft@bitsim.se>
Received: from amsfep20-int.chello.nl (amsfep20-int.chello.nl [213.46.243.18])
	by ozlabs.org (Postfix) with ESMTP id 099F467A71
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 22:41:26 +1100 (EST)
Received: from [192.168.0.27] (really [80.216.175.121])
	by amsfep20-int.chello.nl
	(InterMail vM.6.01.04.01 201-2131-118-101-20041129) with ESMTP
	id <20050303114119.HQRM1891.amsfep20-int.chello.nl@[192.168.0.27]>
	for <linuxppc-embedded@ozlabs.org>; Thu, 3 Mar 2005 12:41:19 +0100
Message-ID: <4226F904.5010104@bitsim.se>
Date: Thu, 03 Mar 2005 12:46:12 +0100
From: Jakob Viketoft <jakob.viketoft@bitsim.se>
MIME-Version: 1.0
To: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Adding machine types to the kernel tree...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

Are there any certain policys or religious issues about adding machine 
types to the (ppc40x) kernel tree, and who's responsible for kicking 
stuff like this up the main tree?

Specifically, I would like to replace the PowerPC405 support for the 
Xilinx ML 300 (development board) with generic Xilinx Virtex-II Pro and 
Virtex4 support (FPGAs). In my opinion, the end target isn't the 
development boards, but the custom configuration it all will run on in 
the end, and so things would benefit from a more general support. Do 
anyone have any insightful views/opinions on this or comments of any kind?

Clearly, there seem to be some demand for this lately according to 
traffic on the list...

Cheers!

	/Jakob
