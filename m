Date: Sun, 6 Feb 2000 02:22:17 -0800 (PST)
From: Brad Midgley <brad@turbolinux.com>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] little-endian dmasound silently fails
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000204221814.20504A-100000@ofey.inetnebr.com>
Message-ID: <Pine.LNX.4.20.0002060210380.16199-100000@mail.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> don't think this is dmasound's fault.  Luckily for us, many "broken"
> OSS-compatible apps tend to work just fine if we simply modify them to
> ask for AFMT_S16_NE not *_LE, though performance critical apps should
> be fixed with more effort.

is the app broken because it tries to use _LE formats?

i agree it's not optimal and reflects laziness on the developer's part to
try to make everything work as if it's little-endian, but that the api
allows it, right?

Brad
brad@turbolinux.com | http://www.turbolinux.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
