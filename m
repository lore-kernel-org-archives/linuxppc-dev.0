To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gdbserver, find_extend_vma(), and VM_GROWSDOWN 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 07 Jul 2003 12:05:23 EDT."
             <20030707120523.B4527@borg.org>
Date: Mon, 07 Jul 2003 18:37:19 +0200
Message-Id: <20030707163724.BBB5DC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030707120523.B4527@borg.org> you wrote:
>
> I am having gdbserver problems.  I can run gdbserver and attach to it
> with gdb, but the peeks into the application space are failing.

Where did you get your (Cross-) GDB and  gdbserver  from,  and  which
versions are these?


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
We have phasers, I vote we blast 'em!
	-- Bailey, "The Corbomite Maneuver", stardate 1514.2

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
