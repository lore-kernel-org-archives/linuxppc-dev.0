Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "'Torben Mathiasen'" <torben.mathiasen@hp.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Anyone using uClibc on a 405GP platform?
Date: Tue, 24 Feb 2004 12:18:34 +0100
Message-ID: <002c01c3fac7$f1d6adc0$0a01a8c0@LUMENTIS02>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <20040224110901.GB2970@tmathiasen>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Hi,
>
> Does anyone successfully use uClibc on a 405GP platform? I
> tried compiling
> uClibc but all my dynamic apps just segfault. Its the shared
> library loader
> that segfaults immediately after execve(). I tried both a
> recent 2.4 and 2.6
> kernel with the same result. Also using latest 0.9.26 uClibc.
>
> Has anyone gotten this to work?
>
> On my i386 platform uClibc works very well.

ldso is broken in 0.9.26 uClibc for powerpc, try latest uClibc CVS.
There might be some problem with dlopen and friends in CVS still.

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
