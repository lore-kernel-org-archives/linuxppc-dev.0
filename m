Message-ID: <9CFB9DA5261CD611A29B00508B789048071AAB8F@ex-deu-munich02.force.de>
From: "Demke, Torsten" <Torsten.Demke@fci.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC852T with SCC3 and SMC1
Date: Wed, 10 Dec 2003 18:23:57 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

At one of our boards were using the MPC852T.
It will use the SMC1 as UART _and_ SCC3 with ethernet.
(SCC4 will also run  ethernet.)
I know that SCC3 will overlap the Parameter RAM of SMC1 and
I guess that there is a microcode patch to relocate the SMC1.

There is already a microcode patch mentioned in the 8xx_io/ directory
but it doesnt work at my board. Somebody uses this microcode to relocate
SMC1? (to which address?)

I also tried to find a microcode patch for MPC852T
at the motorola web-site but without success.
Can anybody give me a hint where to find this microcode?

Thanks for your help.

Best regards,

Torsten Demke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
