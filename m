MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Time delay using jiffies
Date: Fri, 7 Mar 2003 09:55:32 -0300
Message-ID: <B7AC573479F05C438F232539B961A168095073@CUR1006V.br002.siemens.net.br>
From: "OTAVIO ISAMU SUGENO" <otavio.sugeno@siemens.com.br>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody,
I use jiffies to stamp a time on a message and send to another computer.
Both (computer and custom board) have the same time reference when
starting a connection. I am using a MPC860T and its internal RTC.
I notice that after some time, the time I stamp on the message have a
delay (1 second after 2 or 3 minutes) comparing to the other computer.
Did anybody have this problem or can help me to fix it? I am not sure if
it is a hardware problem or could be solve by software.
Thanks.

Sugeno, Otavio I


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
