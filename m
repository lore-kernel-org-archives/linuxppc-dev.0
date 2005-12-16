Return-Path: <addison.baldwin@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.201])
	by ozlabs.org (Postfix) with ESMTP id 32797688BA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Dec 2005 07:01:17 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id i27so512194wxd
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Dec 2005 12:01:16 -0800 (PST)
Message-ID: <af313df20512161201u39280d30kdf1ace1c4569d50a@mail.gmail.com>
Date: Fri, 16 Dec 2005 20:01:16 +0000
From: Addison Baldwin <addison.baldwin@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Unable to open an initial console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I was sucessful to port U-Boot to our 8272 board. Now I'm experiencing
a problem:

Our Kernel hangs with the message that says it was trasnferring
control to linux. A post morten analyzes indicated that it stopped at
"Unable to open an initial console" in the memory sapce where console
output should be out (in the sdram, like I had found somewhere in this
list, how to do it).

I have checked the bootargs values, it is ok:
bootargs root=3D/dev/ram console=3DttyS0,115200

 We also checked our "/dev" and there was a link to console, pointing
ttyS0. Also, ttyS0 was there too.

Does anyone have any idea how to fix it?
