Message-ID: <1072F1A27E99D3119747005004B9A380EB98CE@MAIL>
From: Brett Carswell <BrettC@nulec.com.au>
To: "'Liu HongXun-a16975'" <a16975@motorola.com>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Why I can't compile linuxppc using DWARF format as debugging
	?
Date: Thu, 19 Apr 2001 14:12:20 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I want to get a debug version of linux2.2.14 for ppc. The
> debug information should be in DWARF format.
> So, I use the option "-gdwarf" to compile the kernel. But
> that failed,telling me :
>
> {standard input}: Assembler messages:
> {standard input}:42: Error: Rest of line ignored. First
> ignored character is `.'.
> {standard input}:43: Error: Rest of line ignored. First
> ignored character is `.'.
> {standard input}:52: Error: Rest of line ignored. First
> ignored character is `.'.
> ...
>

Try using -gdwarf-2. It fixed that problem for me.

Brett

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
