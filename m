Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem on unresolved symbol
Date: Thu, 18 Sep 2003 12:00:20 +0800
Message-ID: <000501c37d99$618e9b70$9702a8c0@newrock2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
In-reply-to: <001601c37d51$019c2860$6401a8c0@sazabimobile>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

In my driver, I use the request_8xxirq() to connect my ISR function to IRQ. Building is OK, but, when I use insmod to load this module into kernel, it report " unresolved symbol request_8xxirq ". I found that in fcc_enet.c, it also use request_8xxirq() to do. Why does my action unsuccessed ?

Could you help me?

Thanks in advance!
John

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
