In-Reply-To: <20040609131408.33319.qmail@web15205.mail.bjs.yahoo.com>
Subject: Re: How to set current time to 8xx RTC through Linux application?
To: Song Sam <samlinuxppc@yahoo.com.cn>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <OFAAD6E391.94B93EC5-ON85256EAE.005413DF-85256EAE.00543302@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Wed, 9 Jun 2004 11:19:40 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If you are using ELDK-3.0 and it's development root filesystem, hwclock
does the trick.

David

>
> I added 8xx RTC driver both on U-Boot and Linux
> kernel.And I could set current time right under
> U-Boot.But I have no idea on making it through Linux
> application?I could read it with following code but
> how to set it?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
