Return-Path: <Leonid@a-k-a.net>
Received: from mis011.exch011.intermedia.net (mis011.exch011.intermedia.net
	[64.78.21.10]) by ozlabs.org (Postfix) with ESMTP id 702E667BDC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Nov 2006 13:54:11 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: ELDK initial installation for FC 4.
Date: Thu, 16 Nov 2006 18:54:13 -0800
Message-ID: <406A31B117F2734987636D6CCC93EE3C810B2D@ehost011-3.exch011.intermedia.net>
From: "Leonid" <Leonid@a-k-a.net>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi:

I've downloaded ppc-2006-01-11_amcc.iso file, burned it on CD, mounted
CD, copied stuff into /opt/eldk, ran install - everything as explained
on web. I have following stuff in /opt/eldk now:

[leonid@localhost eldk]$ ls -al
total 564
drwxr-xr-x  13 root root   4096 Nov 16 18:50 .
drwxr-xr-x   5 root root   4096 Nov 16 17:33 ..
drwxr-xr-x   2 root root   4096 Nov 16 18:51 bin
drwxr-xr-x   2 1543 1543   4096 Jan 13  2006 common
-rwxr-xr-x   1 1543 1543   1620 Jan  5  2005 ELDK_FIXOWNER
-rwxrwxr-x   1 1543 1543   5468 Dec 17  2005 ELDK_MAKEDEV
drwxr-xr-x   5 1543 1543   4096 Nov 16 18:50 etc
drwxr-xr-x   2 1543 1543   4096 Jan 13  2006 icons
-rwxr-xr-x   1 1543 1543 414416 Jan 13  2006 install
drwxr-xr-x   3 1543 1543   4096 Jan 13  2006 ppc_4xx
drwxr-xr-x   3 1543 1543   4096 Jan 13  2006 ppc_4xxFP
-rw-rw-r--   1 1543 1543  73797 Jan  5  2006 README.html
drwxr-xr-x   2 1543 1543   4096 Jan 13  2006 RPMS
drwxr-xr-x   2 1543 1543   4096 Jan 13  2006 sys
drwxr-xr-x   4 1543 1543   4096 Jan 13  2006 tools
drwxr-xr-x  10 root root   4096 Nov 16 18:50 usr
drwxr-xr-x   5 root root   4096 Nov 16 18:50 var
-rw-r--r--   1 1543 1543     34 Jan 13  2006 version

Is it going to work for Fedora Core 4 my PC is running?

Thanks,

Leonid.
