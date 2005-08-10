Return-Path: <wd@denx.de>
To: "Debora Liu" <deboralh@fel.com.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Aug 2005 17:37:02 +0800."
	<20050810093254.3E98667EF5@ozlabs.org>
Date: Wed, 10 Aug 2005 11:48:40 +0200
Sender: wd@denx.de
Message-Id: <20050810094840.C8986352566@atlas.denx.de>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: Re: 8xx: i2c-algo-8xx - fixed timeout detection and transmission
	errors
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Debora,

in message <20050810093254.3E98667EF5@ozlabs.org> you wrote:
> 
> >I had some problems on my MPC855M based board when I tried to access the
> >i2c bus.
> 
> Try update i2c-algo-8xx.c

I guess this will not solve Cajus' problems. Please take the time and
read his message again and you will see that his problems  will still
be present with your driver version. 

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
panic: can't find /
