Date: Thu, 9 Mar 2000 11:24:04 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Sean Harding <sharding@dogcow.org>
cc: David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: compiler optimization? something else?
In-Reply-To: <Pine.GSO.4.05.10003081359150.17227-100000@ophelia.dogcow.org>
Message-ID: <Pine.HPX.4.10.10003091119030.22162-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 8 Mar 2000, Sean Harding wrote:

> (FWIW, another metric...It took 41 minutes to compile a kernel on the
> powermac. It took just over 6 minutes on my PII 350 desktop. The pentium
> was compressing an mp3 at the same time).

Which compiler version are you using ? A full kernel compile takes just
above 7 minutes on my 233 MHz 750 (MVME2400, 1Mb L2 cache but running at a
slow 93 MHz, I suspect Motorola got the L2 setup wrong ) with root and
everything NFS mounted and 32 Mb of RAM (no swap).

Are you sure the L2 cache is enabled ?

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
