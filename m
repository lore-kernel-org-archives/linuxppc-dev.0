Return-Path: <dibacco@inwind.it>
Received: from smtp4.libero.it (smtp4.libero.it [193.70.192.54])
	by ozlabs.org (Postfix) with ESMTP id 7A2C067B2B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 08:58:08 +1100 (EST)
Received: from localhost (172.16.1.210) by smtp4.libero.it (7.0.027-DD01)
	id 43F225B200029922 for linuxppc-embedded@ozlabs.org;
	Tue, 14 Feb 2006 22:58:06 +0100
Received: from smtp20.libero.it ([172.16.1.76])
	by localhost (asav23.libero.it [193.70.193.10]) (amavisd-new,
	port 10024)
	with ESMTP id 25184-15-7 for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Feb 2006 22:58:05 +0100 (CET)
Received: from libero.it (172.16.1.218) by smtp20.libero.it (7.0.027-DD01)
	id 431C3BFF01A523F0 for linuxppc-embedded@ozlabs.org;
	Tue, 14 Feb 2006 22:58:05 +0100
Date: Tue, 14 Feb 2006 22:58:05 +0100
Message-Id: <IUP6CT$AB62363556CBF94AF9C57C018B7462E3@libero.it>
Subject: no sys folder under /proc
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

I don't find the directory sys under /proc. Someone knows why?
Furthermore, printk from a driver are not found in /var/log/messages, wha=
t could be missing?

Bye,
Antonio.
