Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id C961267B6C
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 09:41:51 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	kB9048Xg015858
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Dec 2006 17:04:08 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id kB8MfmhY022376
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Dec 2006 16:41:49 -0600 (CST)
Message-ID: <4579EA2C.4050204@freescale.com>
Date: Fri, 08 Dec 2006 16:41:48 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Can't clone Paul's tree
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

git-clone fails, although cg-clone works.  Using different versions of git 
doesn't change anything.  Others in Freescale have seen the same thing.

$ git clone http://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git 
powerpc.git
error: Couldn't get 
http://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git/refs/heads/for-2.6.20 
for heads/for-2.6.20
The requested URL returned error: 404
error: Could not interpret heads/for-2.6.20 as something to pull


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
