Return-Path: <Murray.Jensen@csiro.au>
Received: from act-ironport-ext-out2.csiro.au (act-ironport-ext-out2.csiro.au
	[150.229.7.38]) by ozlabs.org (Postfix) with ESMTP id 688C167A6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 21:46:04 +1100 (EST)
Message-Id: <6.2.0.14.0.20050318082431.01cd8238@localhost>
Date: Fri, 18 Mar 2005 08:36:27 +1100
To: "Jean Nicollerat MD" <jean.nicollerat@microdev.ch>
From: Murray Jensen <Murray.Jensen@csiro.au>
In-Reply-To: <HMECJAKDCPLOGPDHNAHEAEKHCAAA.jean.nicollerat@microdev.ch>
References: <20050317083415.4BCD5C1510@atlas.denx.de>
	<HMECJAKDCPLOGPDHNAHEAEKHCAAA.jean.nicollerat@microdev.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Cc: Linuxppc-Embedded <linuxppc-embedded@ozlabs.org>
Subject: RE: RTC with TQM823L 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

At 08:27 PM 17/03/2005, Jean Nicollerat MD wrote:
>I have to read message that comme on the CAN bus every 2ms. Then I have to
>show values on the LCD and transfers some message on the RS232.

Sounds like a simple device driver would handle this.

>I need a timer to the check the reception of the messages.

Could this be done by setting a timeout which you keep rescheduling?

Note that the standard clock tick on linux has 10ms resolution - i.e. 100Hz.
You might want to increase this to 1000Hz (i.e. 1ms resolution). I have read
of people doing this in this list.

>I seem it is difficult with linux.

No, its not difficult at all - its very easy. There is a learning curve 
though, just
like anything. Cheers!
                                                                 Murray...
--
Murray Jensen, CSIRO Manufacturing & Infra. Tech.      Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

To the extent permitted by law, CSIRO does not represent, warrant and/or
guarantee that the integrity of this communication has been maintained or
that the communication is free of errors, virus, interception or interference.

The information contained in this e-mail may be confidential or privileged.
Any unauthorised use or disclosure is prohibited. If you have received this
e-mail in error, please delete it immediately and notify Murray Jensen on
+61 3 9662 7763. Thank you.
