Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: Cross compile helper patch
Date: Tue, 27 Aug 2002 21:22:46 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFOEEKDLAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3D6C4C0D.8050204@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> It only goes in your local version of this file.  Everyone has a different
> way they want their cross compilation to work, and those of us that use
> native systems don't like this in the Makefile.  This is the historically
> consistent response to everyone that has submitted a similar
> patch over the years.

A two line change to a make file is not exactly cluttering anything up. If
you are doing native development then you use the distribution as it is
provided. Only if you are doing cross development do you need to create
these files. Just a nice logical in the developers face solution to a
problem that has been solved a 1000 time before.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
