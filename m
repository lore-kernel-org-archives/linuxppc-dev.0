From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mlan@cpu.lu>, Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: l2cr function corrections for G4 (attached now)
Date: Wed, 4 Oct 2000 01:26:17 +0200
Message-Id: <19340828165801.6685@192.168.1.10>
In-Reply-To: <200010032044.WAA16188@piglet.grunz.lu>
References: <200010032044.WAA16188@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>'scuse me...
>
>Files really attached, this time.
>
>I guess it's time to get some sleep...

_get_L2CR was indeed bogus (your patch doesn't seem to change _set_L2CR
or am I blind). Nice catch.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
