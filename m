Message-ID: <20030709071438.18196.qmail@web9703.mail.yahoo.com>
Date: Wed, 9 Jul 2003 00:14:38 -0700 (PDT)
From: None Atall <linux_meis@yahoo.com>
Subject: Re: Problem with starting up 2.4.21 kernel
To: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Cc: linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3F0BAE62.50408@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Yes, Dean is right!
And since are you stuck at the cpm_reset function,
this could probably be the answer!

                  Cheers
                   Dimitris.

--- Dean Matsen <deanm@earthlink.net> wrote:
>
> Dmytro Bablinyuk wrote:
>
> >
> > sramsize = 0x00000000
> > immr_base = 0x02200000
> > bootflags = 0x00000001
> >
> Just a sanity check, but that immr_base sounds
> pretty low to me... we
> always use 0xFxxx0000.
> This is not necessarily wrong, but make sure this is
> what you want. In
> fact, I think I read
> in a comment somewhere that in some cases it MUST
> match the value of
> your boot loader.
>
> Dean
>
>
>


=====
------------------------------------------------------------
-Dhmhtrios Meidanis
-Degree in Mathematics, University of the Aegean.
-Master in Computer Architecture and Digital
 Systems, University of Crete.
 Greece.
------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
