Date: Fri, 25 Aug 2000 23:11:32 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Stefan Berndtsson <stefan@nocrew.org>
cc: sprenger <sprenger@in.tum.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: xf4 and lombard
In-Reply-To: <87em3dyy5m.fsf@hades.nocrew.org>
Message-ID: <Pine.LNX.4.10.10008252237580.21817-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > i will try a new rsynced version of the ati-driver during the weekend.
>
> May I just ask.. how the heck did you get xf4 running on lombard? :)

Use yaboot to boot the kernel, or hack atyfb to resolve the PCI resource
overlap between MMIO and video RAM (I'll post a new patch for this to
debian-powerpc shortly).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
