Message-ID: <000d01c2f32c$940aedd0$256eb796@corebellhychon>
From: =?ks_c_5601-1987?B?wPzH/b+1?= <hychon@corebell.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Microcode patch for using SMC1 and SCC3
Date: Wed, 26 Mar 2003 09:13:45 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello!

My name is hye-yong Chon!

I have some Questions on 850 Processor.

my custom board(850) uses smc1 for console and scc2, scc3 for ethernet.
I know that smc1 does not work because of conflicting dpram area. Then I
download the microcode patch files from motorola.com, but I don't know
how to apply to the kernel?

Where areas are avaliable relocation areas(RPBASE)?

Can you give me some advices and sample?

thank you!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
