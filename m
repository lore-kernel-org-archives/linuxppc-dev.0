To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Bogus interrupt -1
References: <85itjzilbx.fsf@junk.nocrew.org>
	<20010420171327.26883@mailhost.mipsys.com>
From: Lars Brinkhoff <lars.spam@nocrew.org>
Date: 23 Apr 2001 11:52:21 +0200
In-Reply-To: <20010420171327.26883@mailhost.mipsys.com>
Message-ID: <851yqkhrje.fsf@junk.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> >At first, the first six or so messages appeared, but everything seemed
> >fine.  Later, the last messages appeared, and it seemed like one of
> >the two processors in my 2001 Dual G4 had wedged.  According to "top",
> >there was always at least 50% idle time.
> Did you enable distribution of IRQs to all CPUs ?
> I don't think it's completely safe yet.

Yes, IRQ distribution was enabled.  I disabled it, and now the
messages don't appear any more.  However, it still seems like one CPU
hangs after some time.

--
http://lars.nocrew.org/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
