Message-ID: <01139FC052A0D411900B00508B9535FC01748F1E@ZCH07EXM04.corp.mot.com>
From: Liu HongXun-a16975 <a16975@motorola.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Why I can't compile linuxppc using DWARF format as debugging ?
Date: Thu, 19 Apr 2001 12:06:33 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all,
I want to get a debug version of linux2.2.14 for ppc. The debug information should be in DWARF format.
So, I use the option "-gdwarf" to compile the kernel. But that failed,telling me :

{standard input}: Assembler messages:
{standard input}:42: Error: Rest of line ignored. First ignored character is `.'.
{standard input}:43: Error: Rest of line ignored. First ignored character is `.'.
{standard input}:52: Error: Rest of line ignored. First ignored character is `.'.
...

I changed the optimize option, O or O2, but no use. If I omit the optimize option, the kernel can't compile.
My gcc for ppc is from HARD HAT, which is 2.95.2.

Thanks a lot
Rolf Liu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
