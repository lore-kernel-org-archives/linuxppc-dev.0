Subject: RE: Cross compile helper patch
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: acurtis@onz.com
Cc: Dan Malek <dan@embeddededge.com>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <NCBBIINEHIPFGJPLBEIFOEEKDLAA.acurtis@onz.com>
References: <NCBBIINEHIPFGJPLBEIFOEEKDLAA.acurtis@onz.com>
Content-Type: text/plain
Date: 28 Aug 2002 14:01:09 +0200
Message-Id: <1030536069.28699.14.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2002-08-28 at 06:22, Allen Curtis wrote:
>
> > It only goes in your local version of this file.  Everyone has a different
> > way they want their cross compilation to work, and those of us that use
> > native systems don't like this in the Makefile.  This is the historically
> > consistent response to everyone that has submitted a similar
> > patch over the years.
>
> A two line change to a make file is not exactly cluttering anything up. If
> you are doing native development then you use the distribution as it is
> provided. Only if you are doing cross development do you need to create
> these files. Just a nice logical in the developers face solution to a
> problem that has been solved a 1000 time before.
>

This is what I do when cross compiling

make ARCH=ppc CROSS_COMPILE=powerpc-linux-

Needs no changes to the makefile.

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
