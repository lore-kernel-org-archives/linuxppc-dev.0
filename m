Date: Fri, 7 Jul 2000 07:43:23 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re:3dfx Voodoo3/Banshee accelerated driver
In-Reply-To: <Pine.OSF.4.02.10007071009340.1770-100000@ax1305.physik.uni-marburg.de>
Message-ID: <Pine.LNX.4.10.10007070742300.18547-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 7 Jul 2000, Henning Loeser wrote:

> I gave the new 4.0.1 and your xfree86 tree a try. I included the tdfx
> driver in the xfree86.cf file and everything compiled and installed
> nicely. So I decided to send you a quick testreport.
> The driver unfortunately only seems to run in 8bit color. 16bit starts but
> the screen looks very wierd, colors all off ... 24 and 32 bit color modes
> are reported beeing unsupported at the moment. There is also a problem
> with scrolling in windows, no matter which I tried, netscape, a terminal,
> lines of text get clobbed or are not displayed at all. Other that that
> the Server is nice and pretty fast (compared to fbdev...).

The screen artifacts bug is fixed.  Only problem remaining is 24bpp.


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
