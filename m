To: zjzhou@newrocktech.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: about MPC852T board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 28 Feb 2004 18:22:41 +0800."
             <2432.221.137.49.91.1077963761.squirrel@mail.newrocktech.com>
Date: Sun, 29 Feb 2004 17:27:41 +0100
Message-Id: <20040229162746.BE516C0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <2432.221.137.49.91.1077963761.squirrel@mail.newrocktech.com> you wrote:
>
> I know the board based on mpc852T supported by ELDK3.0 are AdderII and
> MPC86xADS.

No, you are wrong.

The ELDK does not support _any_ specific  boards.  It  supports  pro-
cessors  / architectures. For the ELDK version for the PowerPC archi-
tecture, the ppc_8xx group of target packages will support ALL MPC8xx
based boards.

> Could you tell me which boards based on MPC852T are supported by ELDK3.0
> except AdderII and MPC86xADS?

All of them. Including those that don't even exist yet.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Any time things appear to be going better, you have overlooked  some-
thing.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
