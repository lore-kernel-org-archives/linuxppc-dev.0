Date: Wed, 7 Nov 2001 18:12:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: The Plan
Message-ID: <20011107181236.C11617@cpe-24-221-152-185.az.sprintbbd.net>
References: <15337.7275.266062.777161@cargo.ozlabs.ibm.com> <3BE9D64E.78067EED@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BE9D64E.78067EED@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 07, 2001 at 05:48:14PM -0700, Mark A. Greer wrote:

> My guess is to also move cpc700*, cpc710*, sleep.S (in addition to pplus*
> and harrier*).
>
> A separate question...isn't prep_time.c obsolete with todc_time.c?

Almost.  I had this working for my PowerStack months ago I think, but I
had the bits wrong for IBM PRePs.  I'll play with again RSN and
hopefully kill prep_time.c

> What
> about chrp_time.c and others?

No, because it's all OF-based stuff.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
