Message-ID: <3CA1E1B4.B37909AD@mvista.com>
Date: Wed, 27 Mar 2002 10:13:56 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Cc: Val Henson <val@nmt.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
References: <3CA1031D.C072B4D6@mvista.com> <20020326214053.31653@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


benh@kernel.crashing.org wrote:

> Looks fine except for a couple of points:
>
>  - BI_STRUCT is gone, it's BI_DEVICE and the first "type" field is gone,
> that is BI_DEVICE just contains tags without a header. There is no need
> to "know" if a given BI_REC is actually a struct or not, though if we
> still want to do that for debugging reasons, we can define this info is
> stored in the the high bit of the size field (and make sure bi_rec parsing
> routines ignore that bit when reading size)
>
>  - I'm not sure about the "EMBEDDED" dev type. I'd rather have a specific
> type for EV64260_EMBEDDED, and another one for 405_EMBEDDED for example,
> though this is mostly a matter of taste, we have enough room for types
> to define as many as we want ;)
>
> Ben.

Ahh, oops, didn't see this until after I send the second iteration the the
bi_rec's.
I'll send a third in a few minutes.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
