Message-ID: <C7FFFEA58B43D311920D0004ACE5333F0F5359A8@amer25.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Hubert Figuiere'" <hub-linux-arm@trantor.staff.proxad.net>,
	sulvin xavier <sulvinx@yahoo.fr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: I need assembler programming PowerPC4xx
Date: Fri, 19 Sep 2003 09:33:29 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Also don't forget powerpc-gcc -S (some .c file), and/or
powerpc-objdump -d (some exe file).

You can write some simple little functions, adding one line
at a time, etc. and see what each statement assembles to.
A great way to learn any assembler .......



-----Original Message-----
From: Hubert Figuiere [mailto:hub-linux-arm@trantor.staff.proxad.net]
Sent: Friday, September 19, 2003 2:52 AM
To: sulvin xavier
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: I need assembler programming PowerPC4xx



On Fri, 2003-09-19 at 09:50, sulvin xavier wrote:
> Hello all,
> Please, Anyone can send me documentation (or web url)
> for assembler programming PowerPC4xx (programming
> tutorial, example, exercise with correction  ...)
> Thanks in advance,

motorola.com has references manuals for PowerPC assembly.
For sample code, look for .S files in linux/arch/ppc



Hub


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
