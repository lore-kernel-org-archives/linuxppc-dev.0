Date: Mon, 22 Nov 1999 20:40:01 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Christian Zankel <chris@mvista.com>
Cc: linuxppc-devel@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
Message-ID: <19991122204001.A14117@hq.fsmlabs.com>
References: <19991122120429.031138@mailhost.mipsys.com> <19991122143732.B12973@hq.fsmlabs.com> <3839CF18.5D600DE@mvista.com> <19991122165535.A13360@hq.fsmlabs.com> <383A0AA4.1E4227DC@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <383A0AA4.1E4227DC@mvista.com>; from Christian Zankel on Mon, Nov 22, 1999 at 07:31:48PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If bootx/quik could gather the necessary info from the OF tree then stick
it in physical ram somewhere we could pass a pointer to anything with
something like the common bootinfo struct I've been playing with.

Ben, how much work would it take to get bootx to do that?  I know quik
isn't quite there but we could add some code to do something along those
lines.

} That was exactly what I meant.

Yes, I do walk along that path quite often :)  I'm happy to merge in
patches to do that job or talk about ideas.  Do you have anything specific
in mind?

} And of course you need to edit mm/init.c. But if you try to exclude any
} code related to OF and/or residual data there are many more than just
} head.S. (Try to walk along the 'path' of the 8xx implementation). I
} would like to see some kind of an implementation like the m68k tree. 

OF is pretty firmly entrenched in the kernel, that's true.  It could be
pulled out so it's more modular.

} I thought that Dan Mallek is working on the 82xx port. Actually, I'm
} working on a custom designed board based on a 750, and it looks like
} that there are two or more to come in the forseeable future. (I guess
} the ports will be much like the port for the gemini board, i.e. without
} OpenFirmware, and maybe other 'pecularities').

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
