Message-ID: <20040611134910.14601.qmail@web15214.mail.bjs.yahoo.com>
Date: Fri, 11 Jun 2004 21:49:10 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: How to set current time to 8xx RTC through Linux application?
To: Graf Alex <alex.graf@siemens.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <791B3205DB661A42B4BFE5464A7D1D0204B36ECA@chzugexch01.abatos.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graf Alex <alex.graf@siemens.com> wrote£º
> If you did implement the Linux rtc interface, you should be able to
> read/write the time with IOCTLs from your app.
>
> fRtc = open("/dev/rtc", O_RDWR, 0);
> ioctl(fRtc, RTC_RD_TIME, &tm );
> ioctl(fRtc, RTC_SET_TIME, &tm);
>
> Be carefull, System time is NOT equal RTC time! You have to sync it
> periodical.

Thanks for your input.It did make me more flexible to
set RTC.

Best regards,

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
