Date: Mon, 1 Apr 02 19:35:50 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204020335.AA02109@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] ev64260 bi_rec patch
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras <paulus@samba.org> wrote:

> Use the memory pointed to by klimit and increment klimit by the amount
> you use.  You should keep klimit aligned on a 4-byte boundary, I think.

Yeah, I've already figured this out myself by looking at what you do for OF.

I'm working on one really big changeset right now that'll add a
CONFIG_GENERIC_PPC32 configuration, have presistent and searchable bi_recs, a
new and much cleaner GT-64260 implementation, etc. I'll push it into
linuxppc_2_4_alt when it's ready to see the light of day (hopefully tomorrow or
Wednesday).

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
