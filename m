Return-Path: <sja@brightstareng.com>
Received: from zebra.brightstareng.com (206.173.66.57.ptr.us.xo.net
	[206.173.66.57]) by ozlabs.org (Postfix) with ESMTP id 3113D67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Jan 2005 03:53:25 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zebra.brightstareng.com (Postfix) with ESMTP id 5044628C22B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 11:29:35 -0500 (EST)
Received: from zebra.brightstareng.com ([127.0.0.1])
	by localhost (zebra [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 22071-03 for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 11:29:33 -0500 (EST)
Received: from brightstareng.com (unknown [192.168.1.240])
	by zebra.brightstareng.com (Postfix) with ESMTP id B246528C1C2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 11:29:33 -0500 (EST)
Message-ID: <41F916ED.1070705@brightstareng.com>
Date: Thu, 27 Jan 2005 11:29:33 -0500
From: Stuart Adams <sja@brightstareng.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: MPC5200 bogomips
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


  We are only seeing 263.78 bogomips on a MPC5200 running
  at 396 MHz.

  Doesn't this seem way to low ?? With a 603e core I'd expect
  1 bogomip per MHz or better.

  The exact same kernel source running on an 8xx PPC gets about
  1 bogomip per MHZ and my 745 CPU board does 2 bogomips
  per MHz ... the bogomip calibration code is the same for all
  PPC architectures so it seem like it should be an apples-to-apples
  comparison.

-- Stuart
