Return-Path: <annamaya@yahoo.com>
Received: from web53804.mail.yahoo.com (web53804.mail.yahoo.com
	[206.190.36.199]) by ozlabs.org (Postfix) with SMTP id 4AF3167A83
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Jan 2005 05:28:15 +1100 (EST)
Message-ID: <20050124182811.39192.qmail@web53804.mail.yahoo.com>
Date: Mon, 24 Jan 2005 10:28:11 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: ning <ningmin@yahoo.co.jp>, linuxppc-embedded@ozlabs.org
In-Reply-To: <20050123085652.42295.qmail@web605.mail.yahoo.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: Serial console problem on MPC8272ADS board 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I do not know much about the MPC82702ADS but are you
sure that the SCC4 is actually hooked up to an
external serial port on this board? It may be that the
SCC4 may not even be used on this board. Take a look
at the datasheet for the board and see if SCC4 is used
at all.

--- ning <ningmin@yahoo.co.jp> wrote:

> Hello to all
> 
> I am trying to use ttyS1(SCC4) as Linux serial
> console
> port on on MPC8272ADS board.
> but it doesn't work. 
> My linux kernel is 2.4.22,and using u-boot-1.1.1 as
> a
> bootload.
> Linux kernel doesn't output any log information
> after
> u-boot's message:
>  Uncompressing kernel Image ...  OK
>  
> If I use ttyS0(SCC1) as a serial console port,Linux
> will
> startup successfully.
> 
>   CPM UART driver version 0.01
>   ttyS0 at 0x8000 is a SCC
>   ttyS1 at 0x8300 is a SCC
>   ...
> 
> I found serial console port seems be defined in
> /arch/ppc/8260_io/uart.c,
> but it doesn't work enen if I change
> CONFIG_SERIAL_CONSOLE_PORT to 1 (default:0) 
> 
> I wonder serial console port only can be set to
> ttyS0(SCC1) on MPC8272ADS?
> 
> Thanks.
> 
> __________________________________
> Do You Yahoo!?
> Upgrade Your Life
> http://bb.yahoo.co.jp/
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - 250MB free storage. Do more. Manage less. 
http://info.mail.yahoo.com/mail_250
