From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Cordes <peter@llama.nslug.ns.ca>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel lockup
Date: Wed, 16 May 2001 11:21:54 +0200
Message-Id: <20010516092154.16870@mailhost.mipsys.com>
In-Reply-To: <20010516010328.D19015@llama.nslug.ns.ca>
References: <20010516010328.D19015@llama.nslug.ns.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>bigfoot:~# kbdrate -h
>kbdrate: invalid option -- h
>Machine check in kernel mode.
>Caused by (from SRR1=c9030): Unknown values in msr
>
> What do I do to debug this?
>
> The machine is totally locked, not even the SysRQ combination does
>anything.  (control+command+power still resets though, since it is handled
>in hardware on oldworlds.)

Well, I guess that kbdrate is yet another dumb x86'ism that will
directly tap the hardware of a PC's keyboard controller...

Well, I may be wrong, but machine check usually means that you are
trying to access non-existing hardware.

There should be other informations displayed about the crash. Those
should allow you to lookup the location of it in System.map

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
