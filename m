From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Xavier Grave" <grave@ipno.in2p3.fr>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: just compiled a 2.4.19 kernel with smp support...
Date: Tue, 22 Oct 2002 17:00:35 +0200
Message-Id: <20021022150035.4279@192.168.4.1>
In-Reply-To: <200210221136.NAA12538@ipnmail.in2p3.fr>
References: <200210221136.NAA12538@ipnmail.in2p3.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Work fine now, using vmlinux + the option video=ofonly.
>
>Great to use two processors !

What video card do you have ? It doesn't work without
video=ofonly ? It's a radeon or nVidia ? Can you
send me the lspci -vv output (as root)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
