Message-ID: <3B83D964.9DCFA510@mvista.com>
Date: Wed, 22 Aug 2001 12:10:12 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Cc: Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: status of linuxppc_2_4_devel for ppc405gp
References: <EFEAIMDCOOOHIEPHDNFJAEHDDBAA.stefan.roese@esd-electronics.com> <3B83A5D5.F3B7FD11@inn.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kenneth Johansson wrote:

> Well I was waiting on Dan making some kind of statement that his merge was
> ready. Are you saying that he got in enough to actually run the kernel on a
> 405 ?

Almost all of the kernel proper is structurally sound.  I needed to
get the files there so others could also start making their updates.
I'm sure I missed a few little details, so when you see something
let me know.  Some of the patches I have are nearly six months old
and don't apply as well as they should :-).......then I wandered
into bootloader land where nothing works for the 4xx right now.  If
you don't need a 'treeboot' loader, or can stuff an image with a
JTAG debugger, you can get the kernel to boot.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
