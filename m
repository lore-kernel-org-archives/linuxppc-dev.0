Date: Fri, 11 Jun 2004 18:26:19 +0200
From: Colin Leroy <colin@colino.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6.7-rc3: another strange bug(?)
Message-Id: <20040611182619.0ef46253@jack.colino.net>
In-Reply-To: <20040608201921.7059a87a@jack.colino.net>
References: <20040608201921.7059a87a@jack.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 08 Jun 2004 at 20h06, Colin Leroy wrote:

Hi,

> I've installed 2.6.7-rc3, and it seems to work quite fine. However
> something strange happened after a few hours of uptime: pbbuttonsd had
> dimmed the display, I came back on the laptop (iBook G4), moved the
> trackpad, and when the display came back it was all garbled - as when
> UseFBDev isn't used in X. It's ok after a reboot...

again; Happened after ~ 1 day of uptime. Restarting X or switching vts
doesn't help. It started to appear with the rc2 -> rc3 patch...

I'm pretty much clueless about this one :-(
I'll be on holidays for a week (yay!) starting about now, but will
occasionnaly check my mail and could try patches if it helps.

--
Colin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
