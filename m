Message-ID: <937610FE9B70D511B3E700508B8B65770E53B7@MAIL1>
From: Shie Erlich <shie_e@elbit.co.il>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: console prints garbage during boot process
Date: Sun, 18 Nov 2001 19:47:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


during the initial boot process (right after start_kernel calls
console_init), the kernel
starts to blurt garbage to the screen. since i needed a temporary hack to
get me going
i made console_init() init the serial console with {9600, 8n1, no flow
control ...).
although this is the correct setup (since minicom "talks" to the bootrom on
these settings)
i still get garbage. i thought that serial_console_setup() has something to
do with it, but apparently not.

any ideas ?


		thanks,
			Shie Erlich

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
