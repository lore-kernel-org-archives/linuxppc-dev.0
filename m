From: benh@kernel.crashing.org
To: Stefan Jeglinski <jeglin@4pi.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.19pre3 boot problem with ext SCSI
Date: Wed, 20 Mar 2002 11:56:04 +0100
Message-Id: <20020320105604.14401@mailhost.mipsys.com>
In-Reply-To: <p05100301b8bdb1fe0b79@[66.26.75.241]>
References: <p05100301b8bdb1fe0b79@[66.26.75.241]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>This is on a 6500 with an external SCSI (mesh) Yamaha CDRW. With
>2.4.19pre3 I fall into the mon debugger during boot as long as the
>CDRW is powered on (and no keyboard control, as usual for me with
>mon). This does not happen with 2.4.18, both rsynced from
>source.mvista.com::linuxppc_2_4. With the CDRW powered off (but still
>connected), no boot freeze.
>
>I want to remember someone ranting here about a simple mesh patch
>that was again and again being not added to the tree, but I can no
>longer find that message. Was thinking it might be my solution. Any
>clues as to that patch?

First, please tell me what you get in the debugger (at least NIP and LR)
that you can lookup in System.map so I know where it dies.

Also, if you use my rsync, you can put the kernel arg. "adb_sync", that
may help having working kbd in xmon.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
