Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 520AADF20C
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 02:17:27 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m3EGHNUl022098
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 18:17:23 +0200
Message-ID: <01f001c89e4b$05acddd0$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Manual kernel parameters are being ignored
Date: Mon, 14 Apr 2008 18:17:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anyone care to tell me why the parameters I type manually for the kernel are 
being ignored ?

Linux/PPC load: console=ttyUL0,9600 root=/dev/xsa2 rw ip=off
Uncompressing Linux...done.
Now booting the kernel
[...]
[    0.000000] Kernel command line: console=ttyUL0,9600 root=/dev/nfs rw 
ip=on nfsroot=192.168.1.185:/ht

-- 
Guillaume Dargaud
http://www.gdargaud.net/
