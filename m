Message-Id: <200010191621.LAA28113@lists.linuxppc.org>
Date: Thu, 19 Oct 2000 12:21:22 -0400
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
Content-Type: text/plain;
	charset=us-ascii
Subject: Re: openoffice on ppc anyone?
Cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Graichen <graichen@innominate.de>,
        linuxppc-dev@lists.linuxppc.org
To: Tom Rini <trini@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v337)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> Well I've run almost every glibc since gary thomas started releasing 'em
> way back when (thanks gary!) and I've been lucky so far. :)

Me too!  The only real issue for *robust* native threads use are to stay with at least with glibc-2.1.3 (glibc-2.1.2 has some problems with the jdk).

When choosing a glibc-2.1.3 version, stick with either the glibc-2.1.3-5a-rpm which shipped with YDL and LinuxPPC I think) from Franz or his very latest glibc-2.1.3-15f rpm because the intermediate versions had native threads bugs introduced after the glibc-2.1.3 branch was completed (bug fixes which made new bugs!).

The jdk 1.2.2 FCS should be fine for the open office release since it is basically bug for bug compatible with the x86 jdk 1.2.2 (and Sun's jdk 1.2.2 for that matter).

If the jdk 1.2.2 runs into any trouble, let me know and I will fix it and make a special binary for anyone working on the openoffice port (or anyone for that matter).

Just let me know.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
