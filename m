Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Dan Brennan" <dmb8@optonline.net>
Cc: "Paul Mackerras" <paulus@samba.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: RE: eieio rule-of-thumb?
Date: Thu, 23 May 2002 07:42:12 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFMEIBDHAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3CECF4AB.7393E521@optonline.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The Enforce In-Order Execution of I/O (eieio) instruction is used to
> ensure memory
> reordering of noncacheable memory access. Since the 603e does not
> reorder
> noncacheable memory accesses, the eieio instruction is treated as a
> no-op.

That make me feel better for my processor anyway....

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
