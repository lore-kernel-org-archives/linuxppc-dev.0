Return-Path: <edjubenville@adelphia.net>
Received: from mta15.adelphia.net (mta15.mail.adelphia.net [68.168.78.77])
	by ozlabs.org (Postfix) with ESMTP id 7473FDDF96
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Feb 2007 02:13:35 +1100 (EST)
Received: from EJ1 ([75.83.100.4]) by mta10.adelphia.net
	(InterMail vM.6.01.05.02 201-2131-123-102-20050715) with SMTP
	id <20070202141117.JNO7169.mta10.adelphia.net@EJ1>
	for <linuxppc-embedded@ozlabs.org>; Fri, 2 Feb 2007 09:11:17 -0500
From: "Edward Jubenville" <edjubenville@adelphia.net>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: ELDK glibc fcntl(socketFd,F_SETFL, flags) causes Seg Fault
Date: Fri, 2 Feb 2007 06:11:14 -0800
Message-ID: <GPECLCIGPLHEOMGPMCPAEEEBEGAA.edjubenville@adelphia.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <loom.20070201T073939-302@post.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Then I try getting the fd flags:
> fcntl(fd, F_GETFL, flags)

Don't you really need to do this...

  flags = fcntl(fd, F_GETFL, 0)

to get the correct initial state of the flags?

Ed Jubenville
