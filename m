Date: Tue, 30 May 2000 13:28:26 +0200 (MET DST)
From: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
To: linuxppc-dev@lists.linuxppc.org
Subject: fbconsole and 2.4.0test1-ac4
In-Reply-To: <200005300459.XAA05673@lists.linuxppc.org>
Message-ID: <Pine.OSF.4.02.10005301307540.26677-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
as I wrote I switched to 2.4.0-test1-ac4 sources hoping to get my ide-card
to work and had to find out that the console "broke" on my Voodoo3 card. I
must say that I do get the same behaviour under 2.3.99-pre9 therefore I
never continued to try to compile a 2.3.99 kernel.
The consolefont is screwed up completely! It seems like all characters are
divided into 3 parts, bottom middle and upper. Is that correct? The three
parts get displayed strangely. I think the bottom part is displayed at the
top BACKWARDS, the part that should belong on top is displayed at the
bottom. The middle part seems to stay. The BootX penguin is looking really
wierd aswell.
My guess is that it has to do with the different byteorder of the PPC, is
that correct? Where is the console font send to the driver? The driver
works, X works, so I can login and start X and there everything is running
nicely.
The BootX Penguin is displayed correct after I apply Kostas tdfxfb
patches but it doesn't help for the console font.

There is still another issue with 2.4.0 I do have to start the Mac with
extensions disabeled, then activate the G3 cache via a controllpanel and
then use the BootX Application. If I start with extensions the kernel
crashes when it tries to start the System logger. Any hints on that ? It
does boot a 2.2.15 kernel without problems with the extensions enabeled!

Henning

--------------------------------------------------------------------------
Henning Loeser					      Fachbereich Physik
email: henning.loeser@physik.uni-marburg.de	      AG Oberflaechen
						      Philipps-Uni Marburg


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
