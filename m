From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Ray <g4tinker@yahoo.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: idebus=133 ?
Date: Mon, 22 Oct 2001 15:19:38 +0200
Message-Id: <20011022131938.21190@smtp.adsl.oleane.com>
In-Reply-To: <20011021224211.561.qmail@web13105.mail.yahoo.com>
References: <20011021224211.561.qmail@web13105.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>It's my understanding the Mac G4 towers run at a bus
>speed of 133 MHz. However the kernel argument for
>idebus=xx apparently only allows values up to 66. Is
>this intentional?

I don't think this value has any meaning on macs. It's
related to the IDE bus frequency, which is 66Mhz on
Apple "UDMA capable" HW and 33 on older chipsets, but
the ide-pmac.c code does all the calculations internally
and shouldn't rely on the generic idebus value.

>I checked where this was is the kernel source and
>manually changed the limit from 66 to to 133 to see
>what happens. The machine boots fine with no errors.
>The file is: drivers/ide/ide.c. On lines 3159 and 3162
>I simply changed "66" to "133". Then I boot with
>"idebus=133".
>
>Is the 66 limit intentional or should it be changed to
>133?

You don't have to care about it.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
