Message-ID: <00bc01bf58e1$2bf49b80$73f102de@sjzhu>
Reply-To: "Shuangjun Zhu (r44089)" <r44089@email.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Question about the video device driver
Date: Fri, 7 Jan 2000 15:31:09 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The video of MPC823 FADS board only support YCbYCr mode,
so how can I write a device driver for the video of MPC823 FADS board,
to enable the X?

Any suggestion? 
Thanks in advanced.

-----Original Message-----
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Shuangjun Zhu (r44089) <r44089@email.sps.mot.com>
Cc: linuxppc-dev@lists.linuxppc.org <linuxppc-dev@lists.linuxppc.org>
Date: Tuesday, January 04, 2000 6:09 PM
Subject: Re: Question about the video device driver


>
>On Tue, 4 Jan 2000, Shuangjun Zhu wrote:
>> If the data format in the video memory is CbYCrY,
>> the above layer application like Xserver can handle this?
>
>XFree86 doesn't do YCbCr.
>
>Gr{oetje,eeting}s,
>--
>Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org
>
>In personal conversations with technical people, I call myself a hacker. But
>when I'm talking to journalists I just say "programmer" or something like that.
>     -- Linus Torvalds
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
