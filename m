Message-ID: <3AB681C7.DAE8E5A0@mvista.com>
Date: Mon, 19 Mar 2001 14:01:43 -0800
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: Arturo Nunez <artnpp@cs.ucf.edu>
Cc: ppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems Compiling 2_4 for 860
References: <200103161804.NAA21697@iris.cs.ucf.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Arturo,
You did not convert the output from make zImage to an s-records file.
This can be done through objcopy. Then you load the s-records file
and you should not get the error you see.
Cal Erickson
Arturo Nunez wrote:

> Hello:
>         I have been compiling using the MVISTA tools the kernel 2_4 from
>         bitkeeper.
>         The CPU is = XPC860TZP50B5
>         I have follow the following Steps.
>         -       make mrproper
>         -       make rpxcllf_config
>         -       make oldconfig
>         -       make dep zImage
>
>         Finally I may compile the zImage, but when I try to load from the
>         Board, doesnt Recognize the file, the message is :
>
>                 load_tftp(): ** E_RPX_NOT_SREC
>         What should be error ??
>         Regards
>
>         Arturo Nunez
>

--
===========================================================================
Cal Erickson                 MontaVista Software Inc.
Linux Consultant             1237 E. Arques Ave.
Phone (408) 328-0304         Sunnyvale CA 94085
Fax   (408) 328-9204         web http://www.mvista.com
eCode: http://cal@work.com.ecode.com
===========================================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
