To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux/PPC for APUS <linux-apus@sunsite.auc.dk>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dmasound split
References: <Pine.LNX.4.10.10003141114390.12359-100000@opal.biophys.uni-duesseldorf.de>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 14 Mar 2000 12:37:45 +0100
In-Reply-To: Michael Schmitz's message of "Tue, 14 Mar 2000 11:17:29 +0100 (CET)"
Message-ID: <d31z5dwzna.fsf@lxplus006.cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Michael" == Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de> writes:

>> Yep. Time to ship Andreas' TT to SuSE...

Michael> Looks like it. I never really understood what Jes wanted to
Michael> change about the serial layer, and I don't have much time for
Michael> that recently.

The whole design was wrong. The old m68kserial implementation was
running as a master layer controlling the low level devices. Instead
it should be a library of routines the drivers can choose to use if
they want to. The master approach puts too many restrictions onto the
individual drivers.

Linus rejected this approach more than two years ago, and it is never
going into the official tree. I have been telling everybody this for
just as long, but most people seem tohave just gotten tired of it and
started ignoring the message.

Jes

PS: Sorry about random missing characters, the latency from Australia
o Switzerland makes typing emails somewhat interesting.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
