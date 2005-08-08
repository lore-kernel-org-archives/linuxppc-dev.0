Return-Path: <wd@denx.de>
To: "Debora Liu" <deboralh@fel.com.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 08 Aug 2005 14:08:33 +0800."
	<20050808060541.AD39E4299C@denx.de>
Date: Mon, 08 Aug 2005 10:04:53 +0200
Sender: wd@denx.de
Message-Id: <20050808080453.A04D4353A49@atlas.denx.de>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: Re: mpc 8xx watchdog eldh-3.1.1 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050808060541.AD39E4299C@denx.de> you wrote:
> 
> how do I use watchdog with my userspace interface ?
> 
> this wdt_mpc8xx.c is different from standard watchdog userspace interface.

Yes, I know. The "standard" watchdog UI  is  completely  unsufficient
for real world applications.

There is a man page for our driver in Documentation/man4/wdt_mpc8xx.4 


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A person with one watch knows what time it  is;  a  person  with  two
watches is never sure.                                       Proverb
