Return-Path: <littelld@verizon.net>
Received: from vms040pub.verizon.net (vms040pub.verizon.net [206.46.252.40])
	by ozlabs.org (Postfix) with ESMTP id 47498DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Apr 2008 10:59:35 +1000 (EST)
Received: from [192.168.0.6] ([71.240.185.42])
	by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01
	(built Apr
	3 2006)) with ESMTPA id <0JZY005O7ITTRSY1@vms040.mailsrvcs.net> for
	linuxppc-embedded@ozlabs.org; Sat, 26 Apr 2008 19:03:29 -0500 (CDT)
Date: Sat, 26 Apr 2008 18:59:19 -0500
From: Dave Littell <littelld@verizon.net>
Subject: syslogd lockup or hang at startup
To: linuxppc-embedded@ozlabs.org
Message-id: <4813C1D7.1020305@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I occasionally see syslogd hang at system startup.  The startup process
will issue a "failed (1:)" message after about 5 minutes and the system
will continue to boot, but syslogd is nowhere to be found.

Has anyone else seen this and (more importantly) know how to fix it?
One suggestion was to use "-m 0", but that didn't resolve this problem.


Thanks,
Dave
