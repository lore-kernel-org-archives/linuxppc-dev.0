Return-Path: <bwarren@qstreams.com>
Received: from smtp103.biz.mail.re2.yahoo.com (smtp103.biz.mail.re2.yahoo.com
	[68.142.229.217]) by ozlabs.org (Postfix) with SMTP id 3FAD467A3A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 00:54:39 +1000 (EST)
Subject: Re: How to find I2C address?
From: Ben Warren <bwarren@qstreams.com>
To: Sachin Rane <SRane@alphion.com>
In-Reply-To: <8584FDC94AFF7640B17B8A89B23B19B34F655C@sbsserver.AlphionCorp.local>
References: <8584FDC94AFF7640B17B8A89B23B19B34F655C@sbsserver.AlphionCorp.local>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 10:44:58 -0400
Message-Id: <1158072298.6944.32.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: Murali Sampath <MSampath@alphion.com>, linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2006-09-12 at 10:13 -0400, Sachin Rane wrote:
> Hi,
>  
> I am using AMCC PPC440GX evaluation board.
> I want to access serial EEPROM (AP31_U29) present on the board.
> I couldn't find the I2C address for this chip in the board manuals.
>  
> Could you tell me where I can find it?
>  

These things typically have 1 to 3 address pins that are pulled up or
down on the board, with a base address of 0x50.  In other words, it's
probably between 0x50 and 0x57.  To be sure, download the datasheet from
the chip vendor, and look on your board's schematics to see how the
address pins are tied.

There are various ways of probing the bus to get the info indirectly,
but you should really be familiar with your hardware first.

regards,
Ben 
