Date: Fri, 7 Jul 2000 10:45:18 +0200 (MET DST)
From: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
To: linuxppc-dev@lists.linuxppc.org, ajoshi@shell.unixbox.com
Subject: Re:3dfx Voodoo3/Banshee accelerated driver
Message-ID: <Pine.OSF.4.02.10007071009340.1770-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
I gave the new 4.0.1 and your xfree86 tree a try. I included the tdfx
driver in the xfree86.cf file and everything compiled and installed
nicely. So I decided to send you a quick testreport.
The driver unfortunately only seems to run in 8bit color. 16bit starts but
the screen looks very wierd, colors all off ... 24 and 32 bit color modes
are reported beeing unsupported at the moment. There is also a problem
with scrolling in windows, no matter which I tried, netscape, a terminal,
lines of text get clobbed or are not displayed at all. Other that that
the Server is nice and pretty fast (compared to fbdev...).

So I guess I'll go back to fbdev server for now. Kostas 3.9.16 server did
not seem to have these problems. There 24 bit works and the scrolling is
no problem aswell. I just don't get it to cooperate with 4.0.1 ...

Cheers
Henning

--
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me
spread!
--------------------------------------------------------------------------
Henning Loeser					      Fachbereich Physik
email: henning.loeser@physik.uni-marburg.de	      AG Oberflaechen
						      Philipps-Uni Marburg


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
