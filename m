Message-ID: <3B49ECAD.76895397@mvista.com>
Date: Mon, 09 Jul 2001 13:41:01 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: Gary Byers <gb@gse.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: giving up the FPU, MSR[FE0], MSR[FE1], and the FPSCR
References: <Pine.GSO.4.21.0106260032030.15923-100000@gse.com> <15174.24815.352088.954640@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> I believe that does work and that glibc uses it.  Not that that is the
> ideal way to handle it...  Albert Cahalan's suggestion of setting
> FE0/FE1 based on the disposition of the SIGFPE signal is a good one.

There was some discussion about how we handle the exception flags
in FPSCR a long time (a year or more :-) ago.  A search of the
archives may turn up something (I haven't searched).  I know there
was a change to the library and the user ability to set this flags
way back then.......


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
