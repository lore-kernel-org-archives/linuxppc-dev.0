Date: Thu, 13 Dec 2001 16:48:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jeremy Rosen <Jeremy.Rosen@au.thalesgroup.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH]    mutiple uart with devfs
Message-ID: <20011213234831.GC16904@cpe-24-221-152-185.az.sprintbbd.net>
References: <sc0c9d3f.050@gw_tms_syd2.pty.tms.thomson-csf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <sc0c9d3f.050@gw_tms_syd2.pty.tms.thomson-csf.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Dec 04, 2001 at 09:53:57AM +1100, Jeremy Rosen wrote:

> I had weird messages from devfs when the UART driver was trying to
> install itself. Devfs was trying to register a ttyS entry wich already
> existed.
>
> After comparing with serial.c, I think that I understood what was
> going. the attached patch should correct this problem

This looks good, except you shouldn't have the linux version check
either (serial.c is a bad example of a driver).  I'll apply this
shortly.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
