Message-ID: <3F5F3325.170A9378@siemens.com>
Date: Wed, 10 Sep 2003 16:20:21 +0200
From: Agostino Sette ICN-CNX-RD-SW3 <Agostino.Sette@siemens.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Uart problem on SMC MPC860
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
I have a card with a MPC860 and I am using one SMCs as console.
After the power-up of the card, I can access to the system and I have
the
boot prompt:
#root/
If I digit the command
#root/ ps -aux
and I recall it very fast with up arrow, the console hangs very quicly,
I mean no characters are
seen on the console if I press any key..
If I do a telnet on the card, everything work well except the console.
I see the same problem also with the command
ls -la
The only way to hove the console working is to reset the card.
Do you have some suggestion regarding this problem?

Thanks

Agostino Sette                E-mail:Agostino.Sette@siemens.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
