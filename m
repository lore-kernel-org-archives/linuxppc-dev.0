Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx013.isp.belgacom.be (outmx013.isp.belgacom.be
	[195.238.5.64])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF89467A04
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 May 2006 19:36:58 +1000 (EST)
Received: from outmx013.isp.belgacom.be (localhost [127.0.0.1])
	by outmx013.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4H9ajrw016777
	for <linuxppc-embedded@ozlabs.org>; Wed, 17 May 2006 11:36:45 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx013.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4H9ac2s016674
	for <linuxppc-embedded@ozlabs.org>; Wed, 17 May 2006 11:36:38 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [SOLVED] MPC8248 goes berserk when printing messages on the SMC
	console
Date: Wed, 17 May 2006 11:38:07 +0200
References: <200605151828.22727.laurent.pinchart@tbox.biz>
	<200605161709.36387.laurent.pinchart@tbox.biz>
In-Reply-To: <200605161709.36387.laurent.pinchart@tbox.biz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605171138.07498.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

http://www.freescale.com/webapp/sps/utils/SingleFaq.jsp?FAQ-11241.xml

"Question.  Board hangs when the 8260 data cache is enabled. 
 
Answer.  We have found that in some systems, changing the pipline depth to 0 
in the BCR register (BCR[PLDP] = 1) fixes any data cache issues."

I don't know what those "some systems" are, but it seems that on all the 
others the pipeline depth must be set to 1 (BCR[PLDP] = 0). I don't know why, 
and it seems that Freescale doesn't either.

Laurent Pinchart
