Message-ID: <3E2E5E1D.4010002@devcom.cz>
Date: Wed, 22 Jan 2003 10:02:21 +0100
From: Jan Damborsky <Jan.Damborsky@devcom.cz>
MIME-Version: 1.0
To: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem with data cache on MPC823E
References: <DF2B720CF774D21189EE00805FA7FA220517834D@nmrusdunsx3.nielsenmedia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wells, Charles wrote:

>Jan,
>
>The following question assumes that your DRAM is physically organized as
>32-bits wide and connected to CS1.
>
>Do you have the PS field of BR1 set to 00 (32-bit mode) or is it set to 01
>(8-bit mode)? If it's set to 8-bit mode, a burst access becomes 16 bus
>cycles, which looks a lot like 4 bursts.
>
>Regards,
>Charlie
>
>
Yes,
DRAM is organized as 32-bits wide and connected to CS2 (PS field of BR2
is set to 00 - 32 bit mode).
The problem is that burst access becomes 16 bus cycles only from time to
time. And this problem
occurs only when accessing data cache. Instruction cache use always
correct 4 bus cycle bursts.
          Thanks,
          Jan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
