Return-Path: <vijay_padiyar@hotmail.com>
Received: from hotmail.com (bay1-dav6.bay1.hotmail.com [65.54.244.110])
	by ozlabs.org (Postfix) with ESMTP id 5120D67B26
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Apr 2005 15:24:12 +1000 (EST)
Message-ID: <BAY1-DAV6235CD408E72F9B9D71558B370@phx.gbl>
From: "Vijay Padiyar" <vijay_padiyar@hotmail.com>
To: "BusyBox Support" <busybox@mail.busybox.net>,
	"LinuxPPC Support" <linuxppc-embedded@ozlabs.org>
Date: Sat, 16 Apr 2005 10:54:30 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: bftpd (correction)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Correction!! The line I added to /etc/inetd.conf was:

ftp    stream    tcp    nowait    root    /usr/sbin/bftpd    bftpd

Guess you'd realize that on your own, though.

http://www.vijaypadiyar.eu.tf
