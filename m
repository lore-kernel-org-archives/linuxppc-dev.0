Mime-Version: 1.0
Message-Id: <p04320401b5733a720acd@[10.0.1.5]>
In-Reply-To: <200006182257.AAA00912@piglet.grunz.lu>
References: <200006182257.AAA00912@piglet.grunz.lu>
Date: Sun, 18 Jun 2000 22:55:35 -0400
To: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
From: Paul Schinder <schinder@pobox.com>
Subject: Re: Problems handling large files??
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:57 AM +0200 6/19/00, Michel Lanners wrote:
>}
>
>So the 'Cannot allocate memory' comes from the system (libc? system
>call?).
>
>Anybody know what's going on? Can you verify this on a 2.4.0-test
>kernel? FWIW, bonnie _was_ working OK on 2.2.13 (later unverified) and
>2.3.48 (latest benchamrk I have).


All I can tell you is my own experience with 2.3.99 (pre 9, I think,
but it's long gone) and 2.4.0-test1-ac18.  With 2.3.99, I tried doing
a backup with cddump (a perl script that runs mkisofs and cdrecord
for backup up onto CD's), and it failed with both read and write
errors ("fwrite: cannot write" and "cannot open", as I recall).  This
morning, under 2.4.0-test1-ac18, I made a 400+ Mb cd image and burned
it with no trouble.  So if I were you, I'd rsync from Paul's tree
(ac18 as of Saturday morning EDT) and try a 2.4.0.

Of course, the fact that the clock drifted everywhere (xntpd kept on
making ~ 10 s corrections) and that I couldn't get my new UMAX Astra
2200 scanner working under 2.4.0 motivated me to switch to 2.2.16.
(The scanner still won't work, but the clock doesn't drift.)

>
>Clues?
>
>Thanks
>		Michel
>
>-------------------------------------------------------------------------
>Michel Lanners                 |  " Read Philosophy.  Study Art.
>23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
>L-1710 Luxembourg              |
>email   mlan@cpu.lu            |
>http://www.cpu.lu/~mlan        |                     Learn Always. "
>

--
--
Paul Schinder
schinder@pobox.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
