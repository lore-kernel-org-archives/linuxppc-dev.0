Message-ID: <01139FC052A0D411900B00508B9535FC016E0118@ZCH07EXM04.corp.mot.com>
From: Liu HongXun-a16975 <a16975@motorola.com>
To: "linuxppc-dev@lists. linuxppc. org (E-mail)" <linuxppc-dev@lists.linuxppc.org>
Subject: compiling the debug version of linuxppc!
Date: Tue, 17 Apr 2001 10:06:22 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


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

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
