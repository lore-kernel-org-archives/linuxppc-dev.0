Date: Wed, 18 Oct 2000 18:11:47 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Jean-Jacques.Levy@inria.fr
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: video mirroring mode + acrobat reader
In-Reply-To: <200010181539.RAA23713@margaux.inria.fr>
Message-ID: <Pine.LNX.4.10.10010181808580.31628-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I already asked several times, but maybe I missed a message.
>
> Can we have the video mirroring mode working on a PB G3 1999 (Lombard)?
> Simple mirroring mode, not multi-head, with same resolution on both
> LCD screen and video monitor/projector. (I run 2.2.17pre20-ben3)

Just leave the VGA cable disconnected on boot, and plug it in later.
Voila, mirroring mode.

Works with yaboot only, but that's what you should use anyway.

(to answer the logical next question: get the necessary specs from ATI,
f.e. by signing up as XFree developer, and start coding real video
mirroring support, and other fancy things).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
