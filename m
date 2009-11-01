Return-Path: <gicoviello@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by ozlabs.org (Postfix) with ESMTP id 549CEB7C3D
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Nov 2009 20:17:02 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so2293235fga.3
	for <linuxppc-dev@ozlabs.org>; Sun, 01 Nov 2009 01:17:01 -0800 (PST)
MIME-Version: 1.0
Sender: gicoviello@gmail.com
Date: Sun, 1 Nov 2009 10:17:00 +0100
Message-ID: <a265241c0911010117m65335b80g94457a07d0610cbe@mail.gmail.com>
Subject: Fail building 2.6.31.x for CHRP using gcc-4.4.x
From: Giuseppe Coviello <cjg@cruxppc.org>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, we are having trouble while building kernel 2.6.31.x and also
2.6.32rc for CHRP platforms using gcc-4.4.x, the error that give us
the compilation is:

  CC      arch/powerpc/sysdev/indirect_pci.o
  CC      arch/powerpc/sysdev/i8259.o
  LD      arch/powerpc/sysdev/built-in.o
  CC      arch/powerpc/platforms/chrp/setup.o
cc1: warnings being treated as errors
arch/powerpc/platforms/chrp/setup.c: In function 'chrp_event_scan':
arch/powerpc/platforms/chrp/setup.c:378: error: the frame size of 1040
bytes is larger than 1024 bytes
make[2]: *** [arch/powerpc/platforms/chrp/setup.o] Error 1
make[1]: *** [arch/powerpc/platforms/chrp] Error 2
make: *** [arch/powerpc/platforms] Error

The same kernel, with the same configuration builds fine using gcc-4.3.x.

Regards, Giuseppe
