Message-Id: <v03110701b523a6b4d3c5@[129.100.29.243]>
In-Reply-To: <38FDF0C9.85A579AD@erols.com>
References: <200004191429.KAA11052@borg.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 19 Apr 2000 14:11:36 -0400
To: Nelson Abramson <pogtal@erols.com>, Chas Williams <chas@cmf.nrl.navy.mil>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: aty128 and offb and linux-2.3.99pre6
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I submitted my use_of_pll.patch to to Brad and Anthony (the maintainers of
the aty128fb.c driver) and the changes to allow the rage128pro card to work
will eventually make it into the latest development 2.3.99X kernel but it
has not as of yet (today's rsync from Paul devel tree) made it in yet.

You can pretty much hand apply the patch easily and that should help make
things work with 2.3.99preX kernels and rage128pros.

Kevin


At 13:45 -0400 4/19/00, Nelson Abramson wrote:
>Chas Williams wrote:
>
>> i think i have spotted an oversite, offb.c, the aty128 probing should
>> come after the offb probing otherwise, my aty128 comes up as an
>> unsupported framebuffer.  the following patch 'correctly' recoginizes
>> my aty128 now:
>
><snip:patch>
>
>Does this fix the problem w/ the broken 2.3.99 aty128pro driver?
>
>--Nelson Abramson
>
>
>--
>"Apparently if you play the Windows NT CD backwards you hear satanic messages"
>"You think that's bad, if you play it forwards it installs Windows NT!"
>--orlando
>
>


--
Kevin B. Hendricks, Associate Professor of Operations and Information
Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
