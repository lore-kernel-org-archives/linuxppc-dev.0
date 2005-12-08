Return-Path: <gil_madar@radwin.com>
Received: from mx100.qos.net.il (mx100.qos.net.il [80.74.96.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 251F368893
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Dec 2005 03:10:21 +1100 (EST)
Message-ID: <8A7F0BC83EA32C4BBEE5502F0E3D5E6F08E51D@radwin-mail.radwin.ltd.com>
From: Gil Madar <gil_madar@radwin.com>
To: 
Date: Thu, 8 Dec 2005 18:10:10 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Subject: Linux on MPC866
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I'm working on an MPC866 based board. I needed to make changes related to
the RTC, as the MPC866 lacks an RTC, which is one difference between a
MPC860 and an MPC866.
I have no dedicated RTC chip on the board.

I wish to know if somebody ran linux (2.6.14/2.4.25 kernels) on such a
board.
If so: Could [s]he share some insight? what other things to take care of?

Thanks,
Gil
