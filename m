Return-Path: <Viswanatha.reddy@floreatinc.com>
Received: from crc5.bmdc.emailsrvr.com (crc5.bmdc.emailsrvr.com
	[204.119.252.29]) by ozlabs.org (Postfix) with ESMTP id 0841667B3D
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2006 02:58:13 +1000 (EST)
Received: from smtp131.iad.emailsrvr.com (smtp121.iad.emailsrvr.com
	[207.97.245.121])
	by crc5.bmdc.emailsrvr.com (SMTP Server) with ESMTP id 5B68F38FA4
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 11:23:48 -0400 (EDT)
Received: from webmail.alink.net (webmail2.r2.iad.emailsrvr.com [10.238.10.10])
	by relay2.r2.iad.emailsrvr.com (SMTP Server) with ESMTP id 4A81B44E001
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 11:22:58 -0400 (EDT)
Message-ID: <59175.10.238.10.70.1150816978.webmail@10.238.10.70>
Date: Tue, 20 Jun 2006 11:22:58 -0400 (EDT)
Subject: help reg:  transfer of files to target kernel from host(PC)
From: "Viswanatha Reddy" <Viswanatha.reddy@floreatinc.com>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Reply-To: Viswanatha.reddy@floreatinc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




Hi,

We are working on powerPc 405EP taihu board.

Our work is to run the C code and debug the code on taihu board.

for that we istalled ELDK ppc_4xx tools on host system(Which has Fedora
core as OS). We are able to complile C file without board, generated
target file.

We configured NFS server successfully and able to transfer files to target
after U-boot.

Once we entered into the Linux of the kit, We are unable to load the files
from NFS server, we are failed to mount the ELDK tools on Target machine.
When we tried to Ping the server from the target it is pinging.

 From the host(PC) we are communicating the target using Telnet.

 To mount the files we are using the command:

 mount -t nfs 192.168.1.18:/opt/eldk/ppc_4xx /mnt

 We are getting the error saying

 mount:  mounting 192.168.1.18:/opt/eldk/ppc_4xx on /mnt failed no such file
 or directory.

 please help us regarding this..

Best Regards,
Viswanath..
