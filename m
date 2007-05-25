Return-Path: <sasvata.chatterjee@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.225])
	by ozlabs.org (Postfix) with ESMTP id 93907DDE11
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 May 2007 10:28:08 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id v1so653631nzb
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 May 2007 17:28:06 -0700 (PDT)
Message-ID: <a9fc2a630705241728q4d203569n6eb008cc65a7eba9@mail.gmail.com>
Date: Thu, 24 May 2007 19:28:06 -0500
From: "Sasvata Chatterjee" <sasvata.chatterjee@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Latest GCC/GLIBC working combo for a Linux 2.4.x kernel?
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_142061_14556549.1180052886018"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_142061_14556549.1180052886018
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi!

We are using a RHEL/386 machine to cross-compile for Debian/PowerPC (8260)
target, a few year old embedded system that we inherited.  The kernel is
2.4.9. Using crosstools, and following Dan Kegel's notes, the combo we have
is gcc-2.95-3/glibc-2.2.5.

Does anybody have any working version using newer versions of the 2.4 kernel
and newer GCC versions for a powerpc-603e target?  One motivation is to use
BusyBox-1.5.1, but I am told on that list that GCC 2/x is too old (I tried
before I asked, it doesn't compile).

Any help, pointers, example config files for crosstools, etc. would be
really appreciated!

Thanks in advance,
Shash

------=_Part_142061_14556549.1180052886018
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi!<br><br>We are using a RHEL/386 machine to cross-compile for Debian/PowerPC (8260) target, a few year old embedded system that we inherited.&nbsp; The kernel is 2.4.9. Using crosstools, and following Dan Kegel&#39;s notes, the combo we have is 
gcc-2.95-3/glibc-2.2.5.<br><br>Does anybody have any working version using newer versions of the 2.4 kernel and newer GCC versions for a powerpc-603e target?&nbsp; One motivation is to use BusyBox-1.5.1, but I am told on that list that GCC 2/x is too old (I tried before I asked, it doesn&#39;t compile).
<br><br>Any help, pointers, example config files for crosstools, etc. would be really appreciated!<br><br>Thanks in advance,<br>Shash<br><br><br>

------=_Part_142061_14556549.1180052886018--
