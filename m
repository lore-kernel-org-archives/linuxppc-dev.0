From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ralf Weidemann <linuxppc@gatekeeper.informatik.fh-dortmund.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.17pre4-ben0: cisco aironet driver x86 only / airport
 roaming support ?
Date: Tue, 11 Dec 2001 17:29:39 +0100
Message-Id: <20011211162939.29771@smtp.adsl.oleane.com>
In-Reply-To: <3C16283E.90102@gatekeeper.informatik.fh-dortmund.de>
References: <3C16283E.90102@gatekeeper.informatik.fh-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Hi all,
>
>I have two questions..
>
>Should the cisco aironet driver work on ppc too or is it x86 only ?
>I can load the modules, but the card seems not to work. Supports the
>apple airport driver roaming with aironet 350 access points ? I can't
>get both working and I wonder me if it should work.

I don't know, but I know that there was a problem with pcmcia not
getting interrupts on some titanium powerbook models. That I just
fixed in my tree & bk _2_4

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
