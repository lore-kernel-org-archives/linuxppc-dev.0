From: Benjamin Herrenschmidt <bh40@calva.net>
To: Robert Thompson <rothomp3@vt.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: trackpad
Date: Thu, 13 Jul 2000 01:19:05 +0200
Message-Id: <20000712231905.23171@192.168.1.10>
In-Reply-To: <008301bfec55$bc40c580$1a6a1504@strayer.edu>
References: <008301bfec55$bc40c580$1a6a1504@strayer.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>OK, I've tried it. No function from the trackpad still. I downloaded the
>sources and recompiled. Still no trackpad. I turned off "Enable new input
>layer" and make dep'd make clean make vmlinux etc and *still* no trackpad!
>I'm on the Yellow Dog list, and people are starting to report similar
>problems with 2000 "Pismo" PowerBooks and these kernels...

What's up if you add "adb_xpmac_compat" to your kernel command line ? It
works fine on my pismo here.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
