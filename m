Date: Tue, 16 Nov 1999 14:10:12 -0700 (MST)
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Haffner <haffner@astro.wisc.edu>
cc: atong@uiuc.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree, E, and refresh rates...
In-Reply-To: <38319FEA.420FEA00@astro.wisc.edu>
Message-ID: <Pine.LNX.4.10.9911161408530.3875-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 16 Nov 1999, Matt Haffner wrote:

> I was curious if any of you had seen my posting on the users list a bit
> ago about problems that cropped up with Enlightenment 0.16 related to
> monitor refresh rates (B&W/400). There are two minor issues on this
> topic.

E 0.16.2 & anthonys FBDev seem happy here..

> There seems to be a general problem (at least on my system... I haven't
> seen corroboration yet) that XFree chooses the _lowest_ vertical refresh
> modeline instead of the highest one supported by the monitor. I have
> lines like

It takes the 1st one that fits, iirc.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
