Date: Wed, 19 Jul 2000 16:06:40 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Paul Schinder <schinder@pobox.com>
cc: William Blew <wblew@home.com>, Nathan Ingersoll <ningerso@d.umn.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Malloc bug?
In-Reply-To: <p04320404b59b92f1b003@[10.0.1.46]>
Message-ID: <Pine.LNX.3.96.1000719160412.2600E-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 19 Jul 2000, Paul Schinder wrote:

>
> At 9:30 AM -0700 7/19/00, William Blew wrote:
> >
> >Anybody know here man page patches are submitted? After all, if the
> >man page is incorrect, an easy fix is to update it :).
> >
>
> The man page isn't incorrect, at least not the one I have (YDL CS 1.2):

I recall reading something about malloc never failing in some malloc man
page, but I don't recall which OS, which version, etc.

I note in the MkLinux man page, which is probably straight from RedHat:

       free()  frees  the  memory  space pointed to by ptr, which
       must have been returned by a previous  call  to  malloc(),
       calloc()  or  realloc().   Otherwise,  or if free(ptr) has
       already been called before,  undefined  behaviour  occurs.
       If ptr is NULL, no operation is performed.

and

       Crashes in malloc(), free() or realloc() are almost always
       related to heap corruption, such as overflowing  an  allo-
       cated chunk or freeing the same pointer twice.

:-)


David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
