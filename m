Message-ID: <3AF869E7.C5176D36@mvista.com>
Date: Tue, 08 May 2001 17:49:27 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Blythe <blythe@routefree.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
References: <Pine.HPX.4.10.10105072359470.22253-100000@gra-ux1.iram.es> <3AF72CA8.52163E55@mvista.com> <03a001c0d74e$60022c70$4b00000a@foolio1> <3AF73161.26986237@mvista.com> <040a01c0d754$1bf6d5c0$4b00000a@foolio1> <3AF740C0.F65FBCB8@mvista.com> <047301c0d75c$2da00a00$4b00000a@foolio1> <3AF747C4.9C2D74A5@mvista.com> <3AF8348F.FEBF22DE@routefree.com> <3AF856AE.80D0C230@mvista.com> <3AF86649.A5351CD5@routefree.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Blythe wrote:

> Should it run out of the box?  I can give it a try if you have some
> confidence it should build and and run a shell on a walnut board.

Oh, yes, it will get to a shell prompt.  I just don't know what
else you may need to run some of these tests, or what you may
discover later :-).  There have been lots of PCI updates that are
in the pipeline for the upcoming 2.4/2.4_devel that aren't part of
the linuxppc_2_5 tree.  It basically makes the PCI look like all
other PowerPC PCI systems.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
