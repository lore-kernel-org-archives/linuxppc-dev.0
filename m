Return-Path: <leisun124@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.233])
	by ozlabs.org (Postfix) with ESMTP id BD38F67BCF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Nov 2006 15:13:37 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so748585wxd
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Nov 2006 20:13:36 -0800 (PST)
Message-ID: <f9a7e7a80611232013o74fc2c43y7ee10835e4839fcf@mail.gmail.com>
Date: Thu, 23 Nov 2006 23:13:36 -0500
From: "Lei Sun" <leisun124@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: MMU issue on mpc8270
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all:
    While trying to bring up the kernel-2.4.30, my debugger failed to
show memory content after MMU is turned on. So I added some debug
serial_putc() function copied from u-boot. (since u-boot has
intialized the UART). The code did printed out the debug message
untill it reached "mapin_ram()" function.  To be precise, in
map_page() funcion, after pte_alloc() , serial_putc() doesn't work
anymore.

My questions are :

1. in mapin_ram() function, since it uses "bat_mapin_ram()" , why does
it still map in page?
2. why would pte_alloc() affect my serial debug output ?

Rigth now, my kernel does seems to be running, but i just couldn't see
anything on the serial console, I have examined the serial console
portion of the code for many times, couldn't seems any thing wrong.
The worst is that i can't set break point with MMU turned on.

Any suggestion?

Thanks
lei
