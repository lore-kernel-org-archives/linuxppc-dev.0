Return-Path: <dibacco@inwind.it>
Received: from smtp6.libero.it (smtp6.libero.it [193.70.192.59])
	by ozlabs.org (Postfix) with ESMTP id D47D0679E2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Feb 2006 08:38:15 +1100 (EST)
Received: from localhost (172.16.1.79) by smtp6.libero.it (7.0.027-DD01)
	id 43F225FD001D59F3 for linuxppc-embedded@ozlabs.org;
	Wed, 15 Feb 2006 22:38:13 +0100
Received: from smtp0.libero.it ([172.16.1.204])
	by localhost (asav1.libero.it [193.70.192.150]) (amavisd-new,
	port 10024)
	with ESMTP id 05848-08-9 for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 22:38:13 +0100 (CET)
Received: from libero.it (172.16.1.239) by smtp0.libero.it (7.0.027-DD01)
	id 439064B400BFFCF5 for linuxppc-embedded@ozlabs.org;
	Wed, 15 Feb 2006 22:38:13 +0100
Date: Wed, 15 Feb 2006 22:38:13 +0100
Message-Id: <IUR03P$6A233DC5B9B1BF9E2C2513D5DCA9D9EB@libero.it>
Subject: no printk messages in /var/log/messages
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "dibacco\@inwind\.it" <dibacco@inwind.it>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
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

I'm running klogd and syslogd from BusyBox 1.1.0. Some messages are logge=
d to /var/log/messages but no kernel messages. I'm printing KERN_ERR but =
also KERN_EMERG and nothing seen!?!?! If I do cat /proc/kmsg it hangs but=
 nothing print.

Bye,
Antonio.
