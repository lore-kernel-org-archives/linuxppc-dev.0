To: bart@ardistech.com
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>,
	dmalek@jlc.net
Subject: Re: MP8xx: not initialized CPM RAM crash 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 03 May 2002 07:51:23 +0200."
             <3CD2255B.330FA4E4@ardistech.com>
Date: Fri, 03 May 2002 08:40:33 +0200
Message-Id: <20020503064038.64A6111952@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3CD2255B.330FA4E4@ardistech.com> you wrote:
>
> I found in ./drivers/i2c/i2c-rpx.c in rpx_iic_init the structure member
> ii->iic_rpbase != 0. Very likely because ppcboot uses this area as initial
> stack. This causes the kernel to get a machine check during i2c init. Should
> the CPM RAM not be zero'd somewhere during kernel boot?

Which kernel version are you talking about?

I think we fixed this in our version of the 8xx I2C driver long ago.

I don't  think  that  the  whole  CPM  RAM  should  be  zeroed;  it's
sufficient to correctly initialize the necessary fields.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
They weren't that important. They were merely at the top. The  people
who  really  run organizations are usually found several levels down,
where it's still possible to get things done.
                                      - Terry Pratchett, _Small Gods_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
