Date: Wed, 18 Jul 2001 23:36:21 +0100
Subject: Re: powermac (other ppc?) events
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010718223819.4594E2F0E7@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 18, 2001, Joseph P. Garcia wrote:
>[snip]
> - we also have other events we may consider to add, such as headphone
> insert,

this *should properly* be handled by the dmasound driver - it needs to
understand the sound hardware (and on some models shares interrupts with
other sound stuff)

- I just didn't get round to implementing it yet :-(

---

apart from that - as far as sound-related stuff is concerned (e.g. volume
key-presses) - my only care is that controls appear to dmasound through the
ioctl() interface already defined ... to avoid a maintenance nightmare. ...

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
