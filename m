Message-ID: <003301c2101f$f7862730$7c72608c@11091031801>
From: "=?big5?B?tL+upLFkIFwoSmFzb24gVHNlbmdcKQ==?=" <910318@itri.org.tw>
To: "Linux PPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: How use float on MPC860 kernel module?
Date: Mon, 10 Jun 2002 09:41:40 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Now I use float pointer on MPC860 kernel module.
My target MPC860.
My compiler : ppc_8xx-gcc (version 2.95.3)
My CFLAGE set is
CFLAGS :=
$(CPPFLAGS) -Wall -Wstrict-prototypes -O -g -fomit-frame-pointer -fno-strict
-aliasing -lm -msoft-float -D_SOFT_FLOAT

My problem is:
Cann't float point compile correctly on Kernel module?

Problem maybe is :
There is not the library (float soft emulation) on kernel module.

But I need the float on kernel module.

Is there any person who can give me the library that support float soft
emulation
on kernel module?

Thank you very much

-Jason Tseng


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
