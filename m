Return-Path: <Nigel.Cunningham@cyclades.com>
In-Reply-To: <313680C9A886D511A06000204840E1CF0A647439@whq-msgusr-02.pit.comms.marconi.com>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Message-ID: <OF9E028F84.FBBBB03B-ONCA256F7A.007CE308-CA256F7A.007CF6A7@Cyclades.com>
From: Nigel Cunningham <Nigel.Cunningham@cyclades.com>
Date: Fri, 31 Dec 2004 08:44:56 +1000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded-bounces@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Re: inflate returned FFFFFFFD - what does this error exactly mean ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>





Hi.

linuxppc-embedded-bounces@ozlabs.org wrote on 31/12/2004 09:27:53:

> Hi,
>
> After few days of wondering through debugging (and with great help) I
fixed
> (by inserting watch dog resets into beginning of  while loops in zlib
> functions) my first problem -strange reboot failures during decompression
of
> the kernel image by the bootloader.
> However my luck expired beyond this fix so far ... ;-).
> Now I am getting "controlled" failure (during the same decompression as
> described above):
>
> I_BAD
> return Z_DATA_ERROR
> after zlib_inflate
> inflate returned FFFFFFFD
> exit
>
> what does this error exactly mean ?

Going from include/linux/zlib.h, it is a data error: your compressed stream
has somehow been corrupted?

Regards,

Nigel
