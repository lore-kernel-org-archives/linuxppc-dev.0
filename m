From: Jim Thompson <jim@SmallWorks.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15280.42836.272063.381264@zaphod.smallworks.com>
Date: Tue, 25 Sep 2001 10:48:36 -0500
To: fray@mvista.com
Cc: erick205@umn.edu, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Solutions for Fast Software Upgrade in Linux/PPC
In-Reply-To: <3BB0A5EA.A8F7392D@mvista.com>
References: <Pine.SOL.4.20.0109251001370.4999-100000@garnet.tc.umn.edu>
	<3BB0A5EA.A8F7392D@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Doesn't the 'linux bios' project claim that they boot linux (as the
bios) so quickly that the IDE drives haven't come on-line yet, so they
just *reboot* in order to give enough delay to get the drives online?

I'd concentrate on taking the delay() calls to their minimum as a
first step, then see just how bad a simple 'reboot' could be.

--
C++ is like jamming a helicopter inside a Miata and expecting some
sort of improvement.       -- Drew Olbrich

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
