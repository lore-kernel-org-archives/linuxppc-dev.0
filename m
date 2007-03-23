Return-Path: <oparz@compuserve.de>
Received: from demdwug7.mediaways.net (smtp.compuserve.de [62.52.27.101])
	by ozlabs.org (Postfix) with SMTP id 9D5E3DDFA8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Mar 2007 21:43:44 +1100 (EST)
From: <oparz@compuserve.de>
To: linuxppc-embedded@ozlabs.org
Message-ID: <3dcf223d9a87.3d9a873dcf22@compuserve.de>
Date: Fri, 23 Mar 2007 11:43:37 +0100
MIME-Version: 1.0
Subject: ttyS0 ttyS1
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
i have problems to use ttyS1 on my TQM885 Board.

fd1 = open("/dev/ttyS0",O_RDWR);
fd2 = open("/dev/ttyS1",O_RDWR);

I have expected to get different filehandles, but
both handles for ttyS0 and ttyS1 are 0! 

Any help is very appreciated.

_____________________
Dr. Otto Parzhuber
Munich University of Applied Sciences
Fac. of Precision Engineering
