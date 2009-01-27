Return-Path: <edfuchs@uni-kassel.de>
Received: from hrz-ws39.hrz.uni-kassel.de (smtp.hrz.uni-kassel.de
	[141.51.12.230]) by ozlabs.org (Postfix) with ESMTP id A01F3DE0C9
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 21:06:53 +1100 (EST)
Received: from [192.168.101.211] (rs-pc1.rs.eecs.uni-kassel.de
	[141.51.112.154])
	by hrz-ws39.hrz.uni-kassel.de (8.14.0/8.14.0) with ESMTP id
	n0R9sjI8017002
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 10:54:46 +0100
Message-ID: <497ED9E9.1090300@uni-kassel.de>
Date: Tue, 27 Jan 2009 10:54:49 +0100
From: Eduard Fuchs <edfuchs@uni-kassel.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Problem with console init
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I'm working on porting of a Linux Kernel ( Linux-2.6.27-rc5) on an
MPC7448 & Marvell 64460 based PowerPC system. At kernel booting,
messages seems as usually on the serial output. Nevertheless at loading
of the system trough NFS, appears only printk messages from the kernel.
By trying to connect with the system via Telnet, returns following error
„telnetd: getpty: No such file or directory“. Node files in „/dev“ are
existing and the same system works just fine with an older Kernel (2.6.12).

The kernel is started with follows parameters (DTS-file):

bootargs = "console=/dev/ttyS0,115200 root=/dev/nfs
nfsroot=192.168.101.87:/mnt/share/uroot
ip=192.168.102.115:192.168.101.87:192.168.100.1:255.255.252.0:board5:eth0:off";

linux,stdout-path = "/system-controller@fbe00000/serial@12000";

May be somebody can give to me some tips, where can be my eventual
problem, or where I have search for errors! If it is necessary, I can
post more information.

Thank you in advance

Best regards,

Eduard Fuchs


-- 

  Eduard Fuchs                            Telefon:    +49 (561) 804-6596
  Universität Kassel                          Fax:    +49 (561) 804-6588
  Wilhelmshöher Allee 71                   E-Mail: edfuchs@uni-kassel.de
  34121 Kassel                     WWW: http://www.rs.eecs.uni-kassel.de
  Raum 1125:1127          FG Rechnerarchitektur und Systemprogrammierung
