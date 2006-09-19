Return-Path: <jack_zhao@usish.com>
Received: from ms.usish.com (unknown [61.152.162.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 890A967B54
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Sep 2006 14:37:07 +1000 (EST)
Received: from outbound.usish.com (outbound.usish.com [192.168.40.103])
	by ms.usish.com (8.12.11/8.12.11) with ESMTP id k8J3eUpI020611
	for <linuxppc-embedded@ozlabs.org>; Tue, 19 Sep 2006 11:40:30 +0800
Received: from outbound.usish.com (outbound.usish.com [127.0.0.1])
	by outbound.usish.com (8.12.11/8.12.11) with ESMTP id k8J3gpkZ022857
	for <linuxppc-embedded@ozlabs.org>; Tue, 19 Sep 2006 11:42:51 +0800
Received: from IT0010708 (it-0010708.usish.com.cn [192.168.57.113])
	(authenticated bits=0)
	by outbound.usish.com (8.12.11/8.12.11) with ESMTP id k8J3gpDA022852
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Tue, 19 Sep 2006 11:42:51 +0800
From: "jack zhao" <jack_zhao@usish.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: events/0 issue
Date: Tue, 19 Sep 2006 11:48:12 +0800
Message-ID: <006401c6db9e$6e13e0b0$7139a8c0@usish.com.cn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
	I encounter one problem when using PPC8347 system. I am using
gigafar driver in linux kernel 2.6.13.4 version, but when I make the driver
working, I start the samba function, and copy copy file from Windows PC to
PPC system, when copy action starts, the events/0 occupy 40% CPU usage,
while I using another system it is also linux 2.6.13, when copying file to
system, events only occupy 1%, most of CPU loading are in network. Could
some one tell me where is the optimization for that? Thanks.

Best Wishes
Jack Zhao
USI SH R&D Center 86-021-58966996-1122
