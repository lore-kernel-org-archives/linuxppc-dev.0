Date: Wed, 26 Feb 2003 11:33:41 -0500
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: register_serial() confusions
Message-ID: <20030226113341.C23430@borg.org>
References: <20030225193807.A18152@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030225193807.A18152@borg.org>; from kentborg@borg.org on Tue, Feb 25, 2003 at 07:38:07PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Feb 25, 2003 at 07:38:07PM -0500, Kent Borg wrote:
>
> How does register_serial() get called?  (Does it?)

It turns out "Does it?" was key.  If I am on the right track, my
non-module, non-PCMCIA code will never call register_serial().

Yes, I was missing some initialization, and is was my missing adding a
call to my version of serial_console_init().  Oops.  Sorry to be a
bother.


-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
