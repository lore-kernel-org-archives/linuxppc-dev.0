Return-Path: <bwarren@qstreams.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id 23BB8679E9
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 00:18:14 +1000 (EST)
Subject: Re: problems with mounting JFFS2 using CFI for AM29LV160MT on
	ppc8245 k2.4.x
From: Ben Warren <bwarren@qstreams.com>
To: Arun Kumar <arunkat@gmail.com>
In-Reply-To: <edd12c050607260503y58808ecrdbee205fa4e617b3@mail.gmail.com>
References: <edd12c050607210756h71bab7f8ve323edf3bf6077c6@mail.gmail.com>
	<1153498817.19682.149.camel@saruman.qstreams.net>
	<edd12c050607240124gd001d11q77796ab4d13c241b@mail.gmail.com>
	<1153750494.12540.23.camel@saruman.qstreams.net>
	<edd12c050607260503y58808ecrdbee205fa4e617b3@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 10:18:10 -0400
Message-Id: <1154614691.5034.74.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
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

Arun,

Please keep the mailing list CC'd on all correspondence.  As you can
see, I've been busy for the past week and am sure there are others
listening that are more qualified to answer.  Anyway...

On Wed, 2006-07-26 at 17:33 +0530, Arun Kumar wrote:
> Hi Ben ,
> I guess this is the last stage before bringing the flash up .
> 
> I am able to partition and open the particular partition agere-ets1 in
> Vi editor .(without NFS)
> after enabling the MTD_CHAR and MTD_BLOCK support . 
> When I ttry to save the file /text file I get an internal flash
> timeout error .I have programmed  my uWriteTiemout to be 500 .
> 
> I am sending a dump of the out put and the cfi_cmdset002.c as well as
> the .config file snapshots . 
> 
> Please take a look :-) 
> It seems the code on bringup disables fast programming .
Looks like you now have char-based reads working, so I expect your
kernel is now properly configured.  The AMD chip you're using has been
around for a while, so it's unlikely a source-code problem.  

Have you tried mtd-utils?  If not, I recommend installing them on the
board.  The source as well as RPMs are available on-line at a number of
places.  Google will help you here.

regards,
Ben
