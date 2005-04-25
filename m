Return-Path: <mike@compulab.co.il>
Received: from alex (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id 97A3667B2F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Apr 2005 18:48:48 +1000 (EST)
Message-ID: <426CBD2C.6060006@compulab.co.il>
Date: Mon, 25 Apr 2005 11:49:32 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: MPC8272 USB host driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
I'm trying to enable integrated USB host controller on MPC8272.
I'd like to use transaction level interface with automatic SOF 
generation but I do not receive SOF interrupts although I keep them enabled.
What can be the reason of such behavior?

-- 
Sincerely Yours,
Mike Rapoport
