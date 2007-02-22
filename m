Return-Path: <trembfra@cgocable.ca>
Received: from fep7.cogeco.net (smtp2.cogeco.ca [216.221.81.29])
	by ozlabs.org (Postfix) with ESMTP id A744BDDE20
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Feb 2007 10:09:41 +1100 (EST)
Received: from cgocable.ca (smtp2.cogeco.ca [216.221.81.29])
	by fep7.cogeco.net (Postfix) with SMTP id 27D933775
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 17:25:25 -0500 (EST)
Sender: trembfra@cgocable.ca
From: trembfra@cgocable.ca
To: linuxppc-embedded@ozlabs.org
Subject: MPC5200 memory mapped IO
Date: Thu, 22 Feb 2007 17:25:25 -0500
Message-id: <45de1855.1b2.2357.4082@cgocable.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Reply-To: trembfra@cgocable.ca
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

I am working on a driver to interface a FPGA chip with the MPC5200 on the local bus plus and I have two questions.

Is it normal that ioremap work without calling mem_request_region before when accessing to mpc5200 registers?

And do I need to call mem_request_region to access to memory mapped device on local bus plus?

Regards,

Fran=e7ois
