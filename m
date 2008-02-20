Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 85E3EDDE19
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 22:57:15 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 20 Feb 2008 12:57:13 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20080220115713.193460@gmx.net>
MIME-Version: 1.0
Subject: Question about PPC_NATIVE/hash_native_64.c
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm a little bit confused about the hash_native_64.c file, which is compiled
in the kernel, if PPC_NATIVE is defined. PPC_NATIVE seems to be defined also
for 32bit platforms (CHRP, PREP, etc.), but the name of the hash_native_64.c
file and the Makefile suggest that it is for 64bit platforms only.
What is hash_native_64.c actually good for on 32bit platforms and which cpus
can make use of it?

Thanks!

regards,

Gerhard
-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
