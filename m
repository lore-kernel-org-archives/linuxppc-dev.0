From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15529.6574.964969.764183@argo.ozlabs.ibm.com>
Date: Tue, 2 Apr 2002 12:38:38 +1000 (EST)
To: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] ev64260 bi_rec patch
In-Reply-To: <0204011952.AA28527@ivan.Harhan.ORG>
References: <0204011952.AA28527@ivan.Harhan.ORG>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov writes:

> The bi_recs list has a variable length and can't be copied to a static variable
> (unless we agree on a maximum size for it and make a static buffer of that
> size, but someone other than me has to make that decision), and I don't know
> how to make a dynamic memory allocation that early.

Use the memory pointed to by klimit and increment klimit by the amount
you use.  You should keep klimit aligned on a 4-byte boundary, I think.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
