Mime-Version: 1.0
Message-Id: <p04320404b59b92f1b003@[10.0.1.46]>
In-Reply-To: <Pine.LNX.4.10.10007190929270.762-100000@apollo.kulian.net>
References: <Pine.LNX.4.10.10007190929270.762-100000@apollo.kulian.net>
Date: Wed, 19 Jul 2000 13:19:11 -0400
To: William Blew <wblew@home.com>,
        "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
From: Paul Schinder <schinder@pobox.com>
Subject: Re: Malloc bug?
Cc: Nathan Ingersoll <ningerso@d.umn.edu>, linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 9:30 AM -0700 7/19/00, William Blew wrote:
>
>Anybody know here man page patches are submitted? After all, if the
>man page is incorrect, an easy fix is to update it :).
>

The man page isn't incorrect, at least not the one I have (YDL CS 1.2):


RETURN VALUES
        For calloc() and malloc(), the value returned is a pointer
        to the allocated memory, which is suitably aligned for any
        kind of variable, or NULL if the request fails.

        free() returns no value.

        realloc() returns a pointer to the newly allocated memory,
        which is suitably aligned for any kind of variable and may
        be different from ptr, or NULL if the request fails or  if
        size  was  equal  to  0.   If realloc() fails the original
        block is left untouched - it is not freed or moved.

and

NOTES
        The Unix98 standard requires malloc(), calloc(), and real-
        loc()  to  set errno to ENOMEM upon failure. Glibc assumes
        that this is done (and the glibc versions  of  these  rou-
        tines do this); if you use a private malloc implementation
        that does not set errno, then certain library routines may
        fail without having a reason in errno.

>

--
--
Paul Schinder
schinder@pobox.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
