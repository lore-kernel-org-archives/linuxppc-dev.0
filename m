Return-Path: <scott.coulter@cyclone.com>
Received: from CYBORG3.cyclone.com (unknown [69.37.28.78])
	by ozlabs.org (Postfix) with ESMTP id 70BF167A58
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Jun 2006 05:59:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC8560 CPM drivers
Date: Wed, 21 Jun 2006 15:57:14 -0400
Message-ID: <43EB80E07C42E1408726E4905FB96B0466C9CF@CYBORG3.cyclone.com>
From: "Scott Coulter" <scott.coulter@cyclone.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi everyone,

I have a MPC8560 driver availability question that perhaps someone can
answer.

My company has built a board for a customer with an MPC8560 on it.  The
board has been designed so that the CPM can support several I/O
interfaces using an external PMC-Sierra COMET device.  Originally, the
customer was planning to use VxWorks and port an existing pSOS driver
that was written for the CPM on the MPC8260.  They are now inquiring
about linux driver support for the CPM.  I currently have version 2.6.15
of the kernel running on the board.

Does anyone know what exists as far as driver support for the CPM on the
8560?  Specifically, the customer is looking to run the CPM with the
following interfaces:

TDM T1
TDM E1
ATM T1
ATM E1

If there is currently no support, does anyone know if there are any
drivers in the works?

Thanks in advance,

Scott




___________________________________________________________________

  Scott N. Coulter
  Senior Software Engineer
 =20
  Cyclone Microsystems         =20
  370 James Street              Phone:  203.786.5536 ext. 118
  New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com
  U.S.A.                        Web:    http://www.cyclone.com
___________________________________________________________________
