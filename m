Message-ID: <3BE9D64E.78067EED@mvista.com>
Date: Wed, 07 Nov 2001 17:48:14 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: The Plan
References: <15337.7275.266062.777161@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


ok, last one:

My guess is to also move cpc700*, cpc710*, sleep.S (in addition to pplus*
and harrier*).

A separate question...isn't prep_time.c obsolete with todc_time.c?  What
about chrp_time.c and others?

YES, I need to make it mp-safe (as Tom requested).  I will do that soon.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
