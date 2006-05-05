Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 4C0A6679EB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 May 2006 19:40:09 +1000 (EST)
To: Gautam Borad <gautam@eisodus.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: frequent sig 11 with malloc() on mpc8xx 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 05 May 2006 14:13:05 +0530."
	<445B1019.9010103@eisodus.com>
Date: Fri, 05 May 2006 11:40:07 +0200
Sender: wd@denx.de
Message-Id: <20060505094007.0F169353AD3@atlas.denx.de>
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

In message <445B1019.9010103@eisodus.com> you wrote:
> 
...
> We have tested the SDRAM in both U-boot (mtest) and linux, and the tests 
> doesnt show anything
> wrong with the SDRAM.

No, of course not. Please read the FAQ to understand why standard RAM
tests will never detect this type of problem. 

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Here is an Appalachian version of management's answer  to  those  who
are  concerned  with  the fate of the project: "Don't worry about the
mule. Just load the wagon."         - Mike Dennison's hillbilly uncle
