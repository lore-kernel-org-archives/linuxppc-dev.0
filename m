From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <msokolov@ivan.Harhan.ORG>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
Date: Sat, 6 Apr 2002 23:06:24 +0100
Message-Id: <20020406220624.4591@smtp.wanadoo.fr>
In-Reply-To: <0204062023.AA17004@ivan.Harhan.ORG>
References: <0204062023.AA17004@ivan.Harhan.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>: ChangeSet
>:   1.925 02/04/05 23:09:25 msokolov@helium.harhan.org +60 -0
>:   Add generic PPC32 config, implemented for Adirondack, EV-64260A, and K2
>:   New GT-64260 support implementation under CONFIG_GENERIC_PPC32
>:   bi_recs enhancements (persistent, nested, searchable, GT-64260 support)
>:   PPCStar zImage support under CONFIG_GENERIC_PPC32
>:   Many small enhancements along the way
>
>Some commentary is in order on this cset. I strongly recommend that Paulus,
>people interested in bi_recs enhancements, and people interested in GT-64260
>support check it out and give it a good look.
>
> .../...

I haven't look at the patch yet, but is my understanding correct that
you have individual config options enabling the various board support
and that you allow more than one to be selected at one time ?

If that is the case, then that's great. It's also what the arm ach does
and I like it.

>On to bi_recs. I have implemented the persistent, nested, and searchable
>bi_recs which were the consensus of a recent hot discussion on this list
>coached by Mark Greer. It works and is fully backward-compatible with the
>bi_recs in the current 2_4_devel, check it out. While I was at it, I
converted
>the handling of BI_MEMSIZE to the new way. Right now in 2_4_devel it is
>detected in the initial parsing and the value is saved in a global var
>that the

Great ! Looks like you have more time than I do to spend on this. I'll
look at your patch and eventually get it merged asap.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
