Message-ID: <01ce01bf72df$f38d9940$5a01a8c0@blue>
From: "sungyeon" <sungyeon@cosmo.etri.re.kr>
To: "Sebastien Articlaux" <sebastien_articlaux@yahoo.com>,
        <linuxppc-embedded@lists.linuxppc.org>
References: <20000209091331.4718.qmail@web207.mail.yahoo.com>
Subject: Re: CUSTOM MP860 PowerQuiccMH BOARD-Need help to program Flash
Date: Wed, 9 Feb 2000 18:27:55 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'v converted ELF -> s rec -> est bin format
and works fine!!

----- Original Message -----
From: "Sebastien Articlaux" <sebastien_articlaux@yahoo.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, February 09, 2000 6:13 PM
Subject: CUSTOM MP860 PowerQuiccMH BOARD-Need help to program Flash


>
> Hello all PPC man,
>
> I am a student working for MATRA SI in electronic
> section
> We want to run linuxppc on a custom MPC860
> PowerQuiccMH board diskless,networless
> with 64Mo DRAM and 4Mo Flash.
>
> We use EST VisionProbe to debbug and download files
> into Flash and RAM.
>
> Sebastien Tadeoni who worked before me had built
> vmlinuw.initrd with
> embedded 2.2.5 and now my job is to download it to the
> Flash and try to boot...
>
> our Flash start at 0x0 to 0x3FFFFF
>     RAM   start at 0x8000000
>
> But my problem is that when I convert vmlinux.initrd
> (1.11 Mega, ELF Format) to a  *.BIN
> (Our emulator EST Vision Probe convert it to a BIN
> format before downloading into the Flash)
> there is only 26K of program code in the Flash which
> start at 0x100000
>
> I try to add some BIAS before download but it's the
> same.
>
> Do you know what?
>
> How can be sure that my file vmlinux.initrd(ELF
> Format) and my .BIN are correct ?
>
> I think .BIN is not good but i'm not sure...
>
> What do you think about that?
>
> Thank you in advance for your help.
>
> Sebastien ARTICLAUX
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
