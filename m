From: Joe Green <jgreen@mvista.com>
To: David Updegraff <dave@cray.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: applications in HHL 2.0, 405GP
Date: Tue, 18 Sep 2001 12:05:09 -0700
Content-Type: text/plain
References: <200109071118.EAA14228@krakatoa.gigabitnetworks.com> <3BA77B15.2090707@cray.com>
In-Reply-To: <3BA77B15.2090707@cray.com>
MIME-Version: 1.0
Message-Id: <01091812073101.04299@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Updegraff wrote:
> Anyway, I thought it was the "theory" that the kernel was trapping the
> float instructions and emulating them...???

Remember that it's not just a matter of configuring math emulation into
the kernel.  The function call ABI is different for soft vs. hard
float, so library calls will go kerflooey if you mix the two.  If you
stick to all hard float user space, you can use kernel math emulation.

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
