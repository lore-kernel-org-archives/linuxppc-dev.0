Message-ID: <20031202043349.71805.qmail@web40407.mail.yahoo.com>
Date: Mon, 1 Dec 2003 20:33:49 -0800 (PST)
From: Raghu <raghu_dk@yahoo.com>
Subject: UART Driver
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20021206155737.GC9920@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I can generate a "serial line break" using
TIOCSBRK/TIOCCBRK or using the posix all
"tcsendbreak".

I have "serial.c" and these IOCTLs result in
"break_ctl" being called. But I am not able to detect
the line break interrupt on "Line Status Register"
kernel I am using is linux-2.4.22

Warm regards
Raghu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
