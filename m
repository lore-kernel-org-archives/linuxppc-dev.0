Return-Path: <blofeldus@yahoo.com>
Received: from web53504.mail.re2.yahoo.com (web53504.mail.re2.yahoo.com
	[206.190.37.65]) by ozlabs.org (Postfix) with SMTP id 3DF33DDF71
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Aug 2008 05:07:46 +1000 (EST)
Date: Wed, 27 Aug 2008 12:07:44 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
Subject: Re: [PATCH V2] MPC52XX: Don't touch pipelining for MPC5200B
To: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <5890.66500.qm@web53504.mail.re2.yahoo.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> From: Scott Wood <scottwood@freescale.com>
> To: roger blofeld <blofeldus@yahoo.com>
> Cc: Wolfram Sang <w.sang@pengutronix.de>; Arnd Bergmann <arnd@arndb.de>; linuxppc-embedded@ozlabs.org
> Sent: Monday, August 25, 2008 10:36:48 AM
> Subject: Re: [PATCH V2] MPC52XX: Don't touch pipelining for MPC5200B
> 
> roger blofeld wrote:
> > Hi
> >  Since this bug is ATA specific, shouldn't this code be conditioned by 
> CONFIG_IDE ?
> 
> And then what happens if IDE is built as a module?
> 
> -Scott

Good point. Still it seems unfortunate to slow everything down when only ATA requires the fix. I'll just continue to disable this code on my board which has no IDE.

Thanks
-rb



      
