Message-ID: <3A01E424.7FDD26BC@mvista.com>
Date: Thu, 02 Nov 2000 14:01:08 -0800
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: John Jones <john@iigi.net>
CC: LinuxPPC Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ld.so.1
References: <3A01AEB4.B49D209B@iigi.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John,
Try checking in /lib of the host system. Even though binutils
creates files for the target, it runs and requires host software
not target software.

Cal

John Jones wrote:

> I am trying to install the rpm:  hhl-ppc_8xx-binutils-2.10.0.12-1 and I
> am getting the error:
>
> ld.so.1 is needed by hhl-ppc_8xx-binutils
>
> I checked the .../target/lib and that file (link) is there.
>
> Anyone know what I should do?
>
> Thanks.
>
> -John
>
> --
> <Help further Linux by signing the Linux Driver Petition:
> http://www.libranet.com/petition.html>
>

--
===========================================================================
Cal Erickson                 MontaVista Software Inc.
Customer Support Engineer    490 Potrero Avenue
Phone (408) 328-0304         Sunnyvale CA 94085
Fax   (408) 328-9204         e-mail cal_erickson@mvista.com
Pager 877-566-2012           support 1-800-759-8888 pin 202-7489
web http://www.mvista.com    support e-mail: support@mvista.com
eCode: http://cal@work.com.ecode.com
===========================================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
