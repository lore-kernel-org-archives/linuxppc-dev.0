Message-ID: <F7B644B6C3C7D41191F700B0D06888190AAAE8@optic3.ipoptical.com>
From: Huy Vu <huy.vu@ipoptical.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: EST8260 Boot Problem
Date: Mon, 18 Dec 2000 17:55:09 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is what I am using

vmlinuz-sbc8260-2.4.0-test2-1.2.2-3 from the HHL web site
I ran the kernel through the "vxhack" with the mod for LE

Then from the "BKM>" prompt I tried to load the kernel (after a successful
TFTP load) to the Vx's Files system. I know this works because I have loaded
VxWorks shell and run using it

When I load the Linux image I get the following error
-------
>BKM>
>BKM>osboot vmlinuz-sbc8260

Loading file vmlinuz-sbc8260...Done
>BKM>go
>RUN>
!HALT! - [msg90007]* Exception taken; PC = 0x00900000  Software Emulation
>BKM>

--------
Can someone tell me what is going on?

Thanks in advance..
Huy

P.S. What's HHL talking about when they say "estflash" or "estsimm" and
"rmon" is included in the CDK.. I installed all packages and I have yet to
find it...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
