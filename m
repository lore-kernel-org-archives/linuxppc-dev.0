Message-ID: <20011022181106.29532.qmail@web13107.mail.yahoo.com>
Date: Mon, 22 Oct 2001 11:11:06 -0700 (PDT)
From: Dave Ray <g4tinker@yahoo.com>
Subject: Re: idebus=133 ?
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20011022131938.21190@smtp.adsl.oleane.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ben and Tom,

Thanks for the replies. The reason I ask is that when
I use "idebus=66" in the boot argument, the syslog
shows bootup message "using 66MHz bus speed.." rather
than "assuming 33MHz bus speed..". So I assumed the
inclusion of the boot argument sped up the computer.
Are the appearances of these messages in the syslog
fictitious? Or should I simply not go over 66?

-Dave

--- Benjamin Herrenschmidt <benh@kernel.crashing.org>
wrote:
> >
> >It's my understanding the Mac G4 towers run at a
> bus
> >speed of 133 MHz. However the kernel argument for
> >idebus=xx apparently only allows values up to 66.
> Is
> >this intentional?
>
> I don't think this value has any meaning on macs.
> It's
> related to the IDE bus frequency, which is 66Mhz on
> Apple "UDMA capable" HW and 33 on older chipsets,
> but
> the ide-pmac.c code does all the calculations
> internally
> and shouldn't rely on the generic idebus value.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
