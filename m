Return-Path: <dogoil@etinsys.com>
Received: from jupiter.etinsys.com (unknown [220.76.45.3])
	by ozlabs.org (Postfix) with ESMTP id B520967D10
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Jul 2005 12:45:34 +1000 (EST)
Received: from smkim (dogoil.etinsys.com [220.76.45.33])
	by jupiter.etinsys.com (8.11.6/8.11.6) with SMTP id j6M2d5v08833
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Jul 2005 11:39:05 +0900 (KST)
Message-ID: <007301c58e66$10df1170$212d4cdc@smkim>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Fri, 22 Jul 2005 11:35:41 +0900
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="Windows-1252";
	reply-type=original
Subject: MPC860 Linux-2.6.12.2 wu-ftpd error
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
I'm porting linux-2.6.12.2 on a custom MPC860 board.
It boots okay, but whenever I connect to it through ftp,
I get the following error.

[dogoil@genesis ~]$ ftp 192.168.0.3
Connected to 192.168.0.3.
220 kvme316 FTP server (Version wu-2.6.1(1) Mon Mar 7 07:50:41 MET 2005) 
ready.
530 Please login with USER and PASS.
530 Please login with USER and PASS.
KERBEROS_V4 rejected as an authentication type
Name (192.168.0.3:dogoil): dogoil
331 Password required for dogoil.
Password:
421 Service not available, remote server has closed connection
Login failed.
No control connection for command: No such file or directory
ftp>

It goes well with linuxppc_2_4_devel (gotten from denx few days ago)
and the same disk image.
On a custom MPC8245 board there is no such problem.

Is it the problem of linux-2.6.12.2?
Did I get something wrong?

Best regards,

Sangmoon Kim 
