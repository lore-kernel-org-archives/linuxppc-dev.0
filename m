Message-ID: <3F8BF8AD.8070603@dgt-lab.com.pl>
Date: Tue, 14 Oct 2003 15:22:53 +0200
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: another (?) uart.c problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


i have latest uart.c for 8xx from cvs, and there is probelem with
changing speed
i'm using only SMC1 (console /dev/tts/0) and SCC2 (/dev/tts/1)

when i'm changing speed for /dev/tts/1 nothing hapens, changing on
/dev/tts/0 applies to both of them



--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
