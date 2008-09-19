Return-Path: <kmohangda@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.188])
	by ozlabs.org (Postfix) with ESMTP id 51823DE063
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Sep 2008 04:15:48 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so221910rnf.16
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Sep 2008 11:15:46 -0700 (PDT)
Message-ID: <7aa80ced0809191115l4d6f495fm463cb9f33a7f6595@mail.gmail.com>
Date: Fri, 19 Sep 2008 23:45:45 +0530
From: "Mohan K" <kmohangda@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: [Help] Linux MCC driver in SS7 mode for MPC8360 - reg
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I am trying to develop Linux MCC driver in SS7 mode for MPC8360. I
have taken the 8260 MCC driver in HDLC mode published in the
sourceforge.net as reference and trying to develop the driver for SS7
mode.

The module is loaded sucessfully and tesing for TX/RX functionality in
SS7 mode using random data through external loopback. It is receiving
the data intermittently(very inconsistent). Sometimes the TX interrupt
is occuring but the data is not received. I have checked the TX buffer
using BDI debugger and found the data in the buffer, but not getting
received on the RX buffer. All this are done only on the channel-0 and
the other channels(2,4,6,....) are not working. It looks like the MCC
itself is getting strucked when this happens and need to give a
hardware reset to come out. I am trying hard but couldn't track down
to the problem.

Any pointers/sample code/inputs would be helpful for me to proceed,
since I am really strucked up here and couldn't track down. I would
also like to know whether I could follow the same logic/framework
implemented in the 8260 driver or not.

Expecting your help in this regard.

Thanks & Regards,
Mohan
