From: kentborg@borg.org
Date: 4 Dec 2001 22:48:32 -0000
Message-ID: <20011204224832.4724.qmail@borg.org>
To: linuxppc-embedded@lists.linuxppc.org,
	rudolf.ladyzhenskii@act-aus.net
Subject: Re: RE: Abatron for Userland Debugging?
Cc: paq@wavemark.com
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


rudolf.ladyzhenskii@act-aus.net wrote on 12/4/01 5:27 pm:
>Why?
>
>You only need Abatron in the
>cases where kernel crashes.
>There is gdb for user
>applications.

Why?  Because gdbserver is acting strange (can stop at a breakpoint,
but won't step or continue). Maybe it is ptrace acting up, so I thought
maybe the Abatron could help...

-kb, the Kent who is thinking the Abatron will be useful in watching
ptrace and gdbserver chat with one another.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
