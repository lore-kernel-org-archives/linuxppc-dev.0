Content-Type: text/plain;
  charset="iso-8859-15"
From: Rakesh jagota <j.rakesh@gdatech.co.in>
Reply-To: j.rakesh@gdatech.co.in
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem with kernel loading in PPC IBM405 based board
Date: Thu, 6 Nov 2003 20:05:59 +0530
MIME-Version: 1.0
Message-ID: <f4sdizk28w071ij.110620032000@gda-server>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I am working on PPC IBM 405 based processor board. I have kernel from
"montavista" 2.4.17-mv121 version. I have tried to put the vmlinux image in
the "SDRAM" after doing the all initialization (in boot level).

We are loading the vmlinux in SDRAM at 0x00020000. I am not able to see any
debug message on the serial port. I am not sure about the kernel jump
location. Is there any way to find out the exact location to load the kernel
and jump to proper location.



Thanks & Regards,

Rakesh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
