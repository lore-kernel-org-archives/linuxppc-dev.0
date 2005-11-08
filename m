Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A13CD6868F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 20:09:00 +1100 (EST)
To: Sette Agostino <Agostino.Sette@siemens.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 08 Nov 2005 09:37:07 +0100."
	<69DF49BE936F4441980EC1D59F0ADC2F0108C267@aqlby02a.siemens.it>
Date: Tue, 08 Nov 2005 10:08:57 +0100
Sender: wd@denx.de
Message-Id: <20051108090857.BCE8135265B@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPCBoot 2.0.0 Errors 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <69DF49BE936F4441980EC1D59F0ADC2F0108C267@aqlby02a.siemens.it> you wrote:
> 
> I agree with you concerning the PPCBoot. In fact in other boards we are using U-Boot.
> We tried to use U-Boot for MPC859 but we had some problems we are trying to
> solve.

You cannot solve  these  problems  by  downgrading  to  PPCBoot.  The
852/859/866  processors  are  definitelu *not* supported by PPCBoot -
the required changes of the clock handling were added much later. You
*must* use U-Boot.

> As far as you know to change the boot or the kernel on cards in field is not
> so easy :-(

You mean you shipped boards to customers in  the  field  in  a  state
where you did not even decide for a final version of the boot loader?
Gosh...

> We found an unexpected beahviour regarding the Linux time tick. 

...whichis probablky cause by using PPCBoot which does not understand
to deal with a 859.

> Another interesting point is that the same kernel works well on other TQM8xx
> modules, but not fot TQM859.

U-Boot is running perfectly fine on the TQM859 - we have these boards
here in our virtual lab; they are tested on a regular base.

> I will try to introduce the U-Boot, but I am not confident it will solve the
> problem, what do you think about it?

I can *guarantee* you that PPCBoot is definitely worse on your hardware.

> Last question, which is the appropriate mailing list?

u-boot-users

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Always leave room to add an explanation if it doesn't work out.
