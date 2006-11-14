Return-Path: <dan@embeddedalley.com>
Received: from smtp105.biz.mail.re2.yahoo.com (smtp105.biz.mail.re2.yahoo.com
	[206.190.52.174]) by ozlabs.org (Postfix) with SMTP id 1548767CC0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Nov 2006 05:39:17 +1100 (EST)
In-Reply-To: <200611141345.21260.laurent.pinchart@tbox.biz>
References: <200611131656.23580.laurent.pinchart@tbox.biz>
	<200611140928.00406.laurent.pinchart@tbox.biz>
	<20061114153313.37513a39@vitb.ru.mvista.com>
	<200611141345.21260.laurent.pinchart@tbox.biz>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <81CD4A4A-7F68-4874-A273-0D3BF9233B16@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: CPM_UART: tcdrain() is broken
Date: Tue, 14 Nov 2006 13:32:38 -0500
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 14, 2006, at 7:45 AM, Laurent Pinchart wrote:

>>> I was hoping the information would be somewhere in the parameter  
>>> RAM :-(

There is lots (well some :-)) of hardware support
for these serial interfaces.  It's not all CPM software
that has to track and process everything.

> There might be another way. Setting TxBD[CR] to 1 will generate the TX
> interrupt only when the stop bit of the last character in the  
> buffer begins
> transmission.

I don't see this happening, because this is only functional
when you program up all of the CTS support as well.  But,
I'm willing to be proven wrong :-)

Have fun!


	-- Dan
