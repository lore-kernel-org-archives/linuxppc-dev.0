Date: Fri, 05 Jan 2001 15:58:40 +0000
Subject: Re: problems when recompiling dmasound modules
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "Michel Dänzer" <michdaen@iiic.ethz.ch>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Message-Id: <20010105170002.57A401BFD9@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:
>> > so they rely on `make oldconfig' and `make dep' instead...
>>
>> vi Makefile, change EXTRAVERSION to append -ids (my usual kinda practice)...
>>
>> make oldconfig dep vmlinux modules
>>
>>  - builds dmasound_core & dmasound_awacs
>>
>> make_install creates a new /lib/modules/2.4.0-test13-pre3-ids and the
>> modules appear to be installed...
>>
>> so... it seems to work for me.
>
> The problem only shows up when I boot the new kernel and try to insmod the
> dmasound modules, have you tried that?

yes, just double-checked (in case my mind was playing tricks...) all OK
AFAICT.

> If make dep is always needed after make oldconfig that may be the problem as I
> also rely on make oldconfig telling me if I have to do that. (real men, you
> know ;)

I'd assumed it was necessary... I can't recall ever seeing the Makefile
finish an oldconfig without saying "now do a make dep"...

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
