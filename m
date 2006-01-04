Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id DA06B68971
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jan 2006 08:11:35 +1100 (EST)
To: Matthias Transier <matthias.transier@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 04 Jan 2006 18:59:35 +0100."
	<b789c2e60601040959n4f6e730dw@mail.gmail.com>
Date: Wed, 04 Jan 2006 22:11:34 +0100
Sender: wd@denx.de
Message-Id: <20060104211134.409E9352ADF@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Segmentation fault with X.org and Coral-P drivers 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Matthias,

in message <b789c2e60601040959n4f6e730dw@mail.gmail.com> you wrote:
> 
> it finally works :-). I had to make a small modification to the x.org
> source code. The file xc/programs/Xserver/hw/xfree86/i2c/xf86i2c.c

Congrats!  To  make  it  perfect:  could  you  please  wrap  up  your
modifications  into  a  patch we can put on our FTP server, so others
can benefit from this, too?

Thanks in advance.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Even historians fail to learn from history -- they repeat the same
mistakes.
	-- John Gill, "Patterns of Force", stardate 2534.7
