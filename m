Date: Tue, 2 Apr 2002 23:09:19 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] ev64260 bi_rec patch
Message-ID: <20020402230919.H6003@altus.drgw.net>
References: <0204020335.AA02109@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204020335.AA02109@ivan.Harhan.ORG>; from msokolov@ivan.Harhan.ORG on Mon, Apr 01, 2002 at 07:35:50PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 01, 2002 at 07:35:50PM -0800, Michael Sokolov wrote:
> Paul Mackerras <paulus@samba.org> wrote:
>
> > Use the memory pointed to by klimit and increment klimit by the amount
> > you use.  You should keep klimit aligned on a 4-byte boundary, I think.
>
> Yeah, I've already figured this out myself by looking at what you do for OF.
>
> I'm working on one really big changeset right now that'll add a
> CONFIG_GENERIC_PPC32 configuration, have presistent and searchable bi_recs, a
> new and much cleaner GT-64260 implementation, etc. I'll push it into
> linuxppc_2_4_alt when it's ready to see the light of day (hopefully tomorrow or
> Wednesday).

Would you mind detailing exactly what's in your 'much cleaner' gt64260
implementation? Like, do you have an SMP-safe gt ethernet driver
perchance? ;)

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
