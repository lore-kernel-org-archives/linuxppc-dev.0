Message-ID: <39EC5DE6.F52E289B@mvista.com>
Date: Tue, 17 Oct 2000 07:10:46 -0700
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: Ralph Blach <rcblach@raleigh.ibm.com>
CC: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How do I make a bigger ram disk
References: <39EC31B2.1FD3F35B@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph,
There are two ways to do this.  You can do it in the source code in
drivers/block/rd.c. there is a hard coded variable there of 4096.

Or simply add 'ramdisk=xxxx' to the kernel command line.

Have fun and enjoy,
Cal Erickson

Ralph Blach wrote:

> OK,
>
> How do I make a bigger ram disk image.  I know this is a really basic
> question but I cant
> seem to find the instructions anywhere.
>
> Chip

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
