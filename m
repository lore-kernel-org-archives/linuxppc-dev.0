Date: Wed, 28 Nov 2001 16:44:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: A little fix
Message-ID: <20011128164423.E29541@cpe-24-221-152-185.az.sprintbbd.net>
References: <0111281705.AA27318@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0111281705.AA27318@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 28, 2001 at 09:05:56AM -0800, Michael Sokolov wrote:
>
> Tom,
>
> I think you've goofed a little bit again:
>
> ChangeSet@1.699, 2001-11-27 15:44:22-07:00, trini@opus.bloom.county
>   'bootinfo' is wrong, 'bi_record' is right, whoops.
>
>   arch/ppc/boot/common/misc-simple.c
>     1.12 01/11/27 15:44:21 trini@opus.bloom.county +3 -5
>     struct bootinfo -> struct bi_record.
>
> After this change misc-simple.c doesn't compile due to a missing semicolon, and
> even if it compiled it would return the wrong address (we need the start of
> bi_recs, not the end). The fix is below.

D'oh.  Not my day... Thanks.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
