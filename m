From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Altivec tools?
Date: Thu, 23 Aug 2001 09:44:05 +0200
Message-Id: <20010823074405.23832@smtp.wanadoo.fr>
In-Reply-To: <200108230602.IAA00772@piglet.grunz.lu>
References: <200108230602.IAA00772@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I'm trying to make use of vlc's Altivec-accelerated IDCT (which so far
>is only meant for MacOS X and doesn't work), so I obviously need an
>Altivec-enabled toolchain.
>
>I've had a look at altivec.org; their tools seem to be relatively old.
>Is that still the best bet? Are the new gcc-3.0 tools Altivec-enabled?
>
>Any gotchas I should know about?

AFAIK, Only an old gcc is available. Paul have implement some
Altivec stuffs in the IDCT of mpeg2dec already, he ended up doing
it entirely in asm (recent binutils do have the altivec as).

I beleive everybody is waiting for Apple to have their patches
merged in...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
