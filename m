MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: bogoMips Problem on MPC8270 Custom Baord
Date: Thu, 6 Nov 2003 06:04:25 -0700
Message-ID: <8039970AF146314597457D3B51A68B382DC0E2@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Your instruction cache is not enabled.

gvb

> -----Original Message-----
> From: Muhammad Sarwar [mailto:msarwar@mangrovesystems.com]
> Sent: Thursday, November 06, 2003 6:30 AM
> Subject: bogoMips Problem on MPC8270 Custom Baord
>
> I am working on MPC8270 based custom board with 2.18.4 kernel. I have
> also enabled PCI Bridge on the board. However once the kernel boots
> up, bogoMips value is only 19.71. Core processor freq is 450 MHz.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
