Message-ID: <B25E2E5A003CD311B61E00902778AF2A02044671@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: "'Dan Malek'" <dan@mvista.com>, Gabriel Paubert <paubert@iram.es>
Cc: frowand@mvista.com, Eli Chen <eli@routefree.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: dcache BUG()
Date: Thu, 10 May 2001 14:20:12 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> What can happen is a lwarx to an address, in some other context a
> simple store to that address (no reservation broken) then a subsequent
> stwcx. to the address will appear successful.  Hmmmm.....several
> ways to fix it, I wonder what will work best.....

Yes, this sounds bad.  However, I wonder if it's really the cause of this
particular bug.  I cannot find any code which does a regular store to the
d_count variables.  All writes to these counters appear to use the atomic
ops.

Brian

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
