From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ralf Weidemann <linuxppc@gatekeeper.informatik.fh-dortmund.de>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.17pre4-ben0: mouse goes wired after sleep on tibook
Date: Tue, 11 Dec 2001 21:01:33 +0100
Message-Id: <20011211200133.12846@smtp.adsl.oleane.com>
In-Reply-To: <3C166497.40209@gatekeeper.informatik.fh-dortmund.de>
References: <3C166497.40209@gatekeeper.informatik.fh-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>After my tibook wakes up from sleep mode the mouse goes
>wired and it is difficult to move it exact around. Looks
>like the touchpad gets not right initialized after sleep.
>Is this a kernel or config problem ?

This is usually a bogus pmud version.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
