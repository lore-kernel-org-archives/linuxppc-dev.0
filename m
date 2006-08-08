Return-Path: <cdumoulin@ics-ltd.com>
Received: from mx1-3.spamtrap.magma.ca (mx1-3.spamtrap.magma.ca
	[209.217.78.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87C7267A2E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 00:02:38 +1000 (EST)
Received: from mail3.magma.ca (mail3.internal.magma.ca [10.0.10.13])
	by mx1-3.spamtrap.magma.ca (8.13.1/8.13.1) with ESMTP id k78DoA44012566
	for <linuxppc-embedded@ozlabs.org>; Tue, 8 Aug 2006 09:50:10 -0400
Received: from ics-ltd.com ([64.26.174.130]) (authenticated bits=0)
	by mail3.magma.ca (Magma's Mail Server) with ESMTP id k78Do7G7021063
	for <linuxppc-embedded@ozlabs.org>; Tue, 8 Aug 2006 09:50:09 -0400
Message-ID: <44D89695.1050501@ics-ltd.com>
Date: Tue, 08 Aug 2006 09:50:13 -0400
From: Christopher Dumoulin <cdumoulin@ics-ltd.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: "Function not implemented" error with syslogd
Content-Type: text/plain; charset=us-ascii; format=flowed
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
I've got an embedded linux system running on a V2Pro-based devlopment 
board, using a 2.6 kernel and ramdisk based on ELDK 4.0.
I'm trying to get syslogd running so I can log printk output to 
/var/log/messages. I'm using a Busybox syslogd that was included in the 
ELDK 4.0 ramdisk image. When I try to start syslogd, I get the following 
error:
syslogd: Couldn't get file descriptor for socket /dev/log: Function not 
implemented

The file /dev/log didn't exist, so I tried to create it with the 
following command, but that doesn't seem to make a difference:
mknod -m 660 /dev/log p

I'm assuming that syslogd does a 'socket' call, which is returning 
ENOSYS. Any ideas about what is going on, or how I can get it working, 
would be appreciated.

Regards,
Chris Dumoulin
-- 
*--Christopher Dumoulin--*
Software Team Leader

<http://ics-ltd.com/>
<http://ics-ltd.com/>

Interactive Circuits and Systems Ltd.
5430 Canotek Road
Ottawa, ON
K1J 9G2
(613)749-9241
1-800-267-9794 (USA only)

------------------------------------------------------------------------
This e-mail is private and confidential and is for the addressee only. 
If misdirected, please notify us by telephone and confirm that it has 
been deleted from your system and any hard copies destroyed. You are 
strictly prohibited from using, printing, distributing or disseminating 
it or any information contained in it save to the intended recipient.
