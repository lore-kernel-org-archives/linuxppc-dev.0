From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Timothy A. Seufert" <tas@mindspring.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCMCIA issues
Date: Thu, 13 Sep 2001 14:54:02 +0200
Message-Id: <20010913125402.29847@smtp.adsl.oleane.com>
In-Reply-To: <p05100300b7c6188b0203@[10.0.0.42]>
References: <p05100300b7c6188b0203@[10.0.0.42]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Sep 13 01:08:38 localhost cardmgr[259]: socket 1: Anonymous Memory
>Sep 13 01:08:38 localhost kernel: cs: unable to map card memory!
>Sep 13 01:08:38 localhost kernel: cs: unable to map card memory!
>Sep 13 01:08:39 localhost cardmgr[259]: executing: 'modprobe memory_cs'
>Sep 13 01:08:39 localhost cardmgr[259]: + modprobe: Can't locate
>module memory_cs
>Sep 13 01:08:39 localhost cardmgr[259]: modprobe exited with status 255
>Sep 13 01:08:39 localhost cardmgr[259]: module
>/lib/modules/2.4.10-pre8/pcmcia/memory_cs.o not available
>Sep 13 01:08:40 localhost cardmgr[259]: get dev info on socket 1
>failed: Resource temporarily unavailable

Not sure for the details as I'm not a PCMCIA expert, but I know
paulus fixes some issues with pcmcia resource allocation. His patch
haven't make it upstream yet but is in my tree.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
