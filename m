Date: Thu, 12 Oct 2000 21:40:26 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Albrecht Dress <adress@mpifr-bonn.mpg.de>
cc: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.2.17pre20-ben3 + pmud-0.7-1: still kernel panic upon wakeup
In-Reply-To: <Pine.SOL.4.21.0010122102460.20095-100000@mpifr-bonn.mpg.de>
Message-ID: <Pine.LNX.4.10.10010122118330.27988-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> I upgraded the pmud package to the latest version (pmud-0.7-1), but
> unfortunately I still get a kernel panic when I try to wake up my Lombard
> again (see message dump below). Does anyone have an idea what goes wrong
> here? Or does anybody have a working pmud/2.2.17pre20-ben3 combination?

Was the CDROM mounted when you put the machine to sleep? I don't see this
with either 2.2.17pre20-ben1 nor with 2.2.18pre14-ben1 (one of which may
be patched in ide-pmac.c from the CDROM sleep debugging sessions).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
