Return-Path: <debbugs@rietz.debian.org>
Received: from rietz.debian.org (rietz.debian.org [140.211.166.43])
	by ozlabs.org (Postfix) with ESMTP id 7DFC3DDE44
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 21:38:17 +1100 (EST)
Subject: Bug#457294: [powerpc] System time not updated after sleep cycle
Resent-Message-ID: <handler.457294.B.119823250615930@bugs.debian.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
From: Michel =?UTF-8?Q?D=C3=A4nzer?= <daenzer@debian.org>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Message-ID: <20071221102141.12236.61438.reportbug@thor.sulgenrain.local>
Date: Fri, 21 Dec 2007 11:21:41 +0100
Reply-To: Michel =?UTF-8?Q?D=C3=A4nzer?= <daenzer@debian.org>,
	457294@bugs.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Package: linux-2.6
Version: 2.6.23-1
Severity: important

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


After wakeup from sleep, the system time is still the same as it was when going
to sleep. I have to restart ntp to get it updated.

This problem didn't occur with previous kernels. It persists in
2.6.23-2~snapshot.9949 but is fixed in
2.6.24~rc5-1~experimental.1~snapshot.9974 . I'm CC'ing the linuxppc-dev list on
this report in the hope that someone there remembers how this was fixed post
2.6.23 upstream and that the fix can hopefully be backported.


- -- System Information:
Debian Release: lenny/sid
  APT prefers unstable
  APT policy: (500, 'unstable'), (500, 'stable'), (102, 'experimental')
Architecture: powerpc (ppc)

Kernel: Linux 2.6.24-rc5-powerpc
Locale: LANG=de_CH.UTF-8, LC_CTYPE=de_CH.UTF-8 (charmap=UTF-8)
Shell: /bin/sh linked to /bin/bash

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHa5O1WoGvjmrbsgARAjGpAJ0TaORdhlrDU1kYPDF7dpAvNK0s0ACfU4mX
erietOhcqZUjsxn+803CxXo=
=I/Op
-----END PGP SIGNATURE-----
