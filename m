Return-Path: <randy.dunlap@oracle.com>
Received: from agminet02.oracle.com (agminet02.oracle.com [141.146.126.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57CA4DDED1
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 06:19:50 +1000 (EST)
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	by agminet02.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id
	m8AJOJAW004213
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 14:24:19 -0500
Message-ID: <48C81ED5.1030701@oracle.com>
Date: Wed, 10 Sep 2008 12:24:05 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: arch/powerpc/boot/.gitignore questions
Content-Type: text/plain; charset=ISO-8859-1
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I was looking at the arch/powerpc/boot/.gitignore file.
Why are all of those non-local-directory files listed there?
E.g., empty.c, inf*.c, inf*.h, zconf.h, zlib.h, zutil.h, etc.

And what is "dtc"?  I see a dtc-src directory, but "dtc" is MIA.
Same for kernel-vmlinux.strip.*

Thanks,
~Randy
