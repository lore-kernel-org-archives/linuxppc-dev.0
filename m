Message-ID: <3AC38873.2E152FA2@mvista.com>
Date: Thu, 29 Mar 2001 14:09:39 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Subodh Nijsure <subodh@best.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: DPRAM parameters for 860P
References: <200103290653.WAA01744@shell9.ba.best.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Subodh Nijsure wrote:

> Currently the 2.4.2 code assumes that DPRAM is always 4KB has anybody
> put together m8xx_cpm_dpalloc() that takes advantage of larger DPRAM on 860P?

Well, you have the code, it is pretty easy to change it.

The intention is to allow Linux to run on all variants, and there
is plenty of DPRAM to support this.  When I have done 860P projects,
they were custom platforms that required the use of the DPRAM for
special uses (like the ATM routing and scheduling tables).  You also
have to consider microcode patches and any constraints they may place
on the DPRAM.

Due to the flexibility of the CPM and all of the different variants,
I'm not sure I could (or want to) put together a configuration script
to cover all of this.  The kernel provides a starting point for everyone.
If we can find generally useful changes, that's fine, but I would like
to avoid the complexities of providing software useful to only one
person or platform.  It's pretty hard to test the effects of any
changes when you do this.

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
