Return-Path: <vijay_padiyar@hotmail.com>
Received: from hotmail.com (bay1-dav2.bay1.hotmail.com [65.54.244.106])
	by ozlabs.org (Postfix) with ESMTP id 955B267B26
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Apr 2005 15:15:52 +1000 (EST)
Message-ID: <BAY1-DAV21348FB427C1B2D3F6BF88B370@phx.gbl>
From: "Vijay Padiyar" <vijay_padiyar@hotmail.com>
To: "BusyBox Support" <busybox@mail.busybox.net>,
	"LinuxPPC Support" <linuxppc-embedded@ozlabs.org>
Date: Sat, 16 Apr 2005 10:46:10 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: i went for bftpd...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi guys

Thanks a lot, guys, for your advice and immediate responses!!!

I finally decided to go with bftpd (http://bftpd.sourceforge.net). I think
it's great for embedded applications. The final stripped executable is about
45 KB in size and it also works with inetd, which is great from my point of
view.

All I needed to do is configure it for my target (MPC8260) and then compile
it with the resulting makefile. Then I copied the final stripped executable
to /usr/sbin on my target's root filesystem and added the following entry to
/etc/inetd.conf on my target:

ftp    stream    nowait    root    /usr/sbin/bftpd    bftpd

After that, I copied the configuration file bftpd.conf supplied with the
bftpd source, customized it according to my requirements and placed it in
the /etc folder on my target. And that was it. I'm now able to connect
successfully and use it just fine.

Regards

Vijay Padiyar

http://www.vijaypadiyar.eu.tf
