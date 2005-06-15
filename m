Return-Path: <Peter.Schaefer-Hutter@tfk-racoms.com>
Received: from rcprx1.tfk-racoms.com (rcprx1.tfk-racoms.com [195.245.55.49])
	by ozlabs.org (Postfix) with SMTP id E862167B67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 01:41:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 15 Jun 2005 17:43:29 +0200
Message-ID: <8E342283C2100540AAC5D1030970547766F7B1@rcexc.racoms.loc>
From: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
To: "Mark Chambers" <markc@mail.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: 2.4.26 and MPC885 context switching time
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> Maybe it would help if you gave more detail about how
> you are measuring these times in your system.

I basically used the two programs from=20
http://www.ibm.com/developerworks/linux/library/l-rt9/
since running lmbench is currently not an option;
however, i'm looking into creating a nfs filesystem that
has enough stuff in it to run lmbench.

  Regards,

    Peter
