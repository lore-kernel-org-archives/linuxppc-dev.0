Return-Path: <blofeldus@yahoo.com>
Received: from web53507.mail.yahoo.com (web53507.mail.yahoo.com
	[206.190.37.68]) by ozlabs.org (Postfix) with SMTP id 29CA42BF14
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Nov 2004 01:53:56 +1100 (EST)
Message-ID: <20041119145354.59388.qmail@web53507.mail.yahoo.com>
Date: Fri, 19 Nov 2004 06:53:53 -0800 (PST)
From: roger blofeld <blofeldus@yahoo.com>
To: tnt@246tNt.com
In-Reply-To: <20041116201654.GA3088@xyzzy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200 FEC Driver on linux 2.6 broken? (fixed again)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>What tree are you exactly using ?
>In mainstream XLB snooping is not configured so if you have the 
>mainstream + added DMA,
>the problem may come from this.
>
>
>    Sylvain

I did a bk clone of the linux-2.5 tree (2.6.10-rc2), then a bk pull of
your tree. You're probably right about the snooping. Since the driver
is working at the moment, I'll wait until your tree is updated before
doing more testing.
Thanks
-rb


		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 
