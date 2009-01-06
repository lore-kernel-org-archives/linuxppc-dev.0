Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-bw0-f10.google.com (mail-bw0-f10.google.com
	[209.85.218.10]) by ozlabs.org (Postfix) with ESMTP id 0DBF1DE4D4
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 23:00:03 +1100 (EST)
Received: by bwz3 with SMTP id 3so20618629bwz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Jan 2009 04:00:00 -0800 (PST)
Message-ID: <c384c5ea0901060354x1658f8c4x2478a6b1fd0901c9@mail.gmail.com>
Date: Tue, 6 Jan 2009 12:54:27 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: avorontsov@ru.mvista.com
Subject: Re: 2.6.28 does not boot on MPC8315E-RDB, or...?
In-Reply-To: <c384c5ea0901051407i2f1b418ep56c2a9f20268459a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c384c5ea0901031458j74d74ba3y359831fff9716d07@mail.gmail.com>
	<008601c96e04$18b74bc0$6b03a8c0@sdelaney2>
	<c384c5ea0901031645q6358f5deibca91cb065fbeb32@mail.gmail.com>
	<20090105165817.GA24565@oksana.dev.rtsoft.ru>
	<c384c5ea0901051407i2f1b418ep56c2a9f20268459a@mail.gmail.com>
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, onramp123@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

On Mon, Jan 5, 2009 at 11:07 PM, Leon Woestenberg
<leon.woestenberg@gmail.com> wrote:
>>
>> 2.6.28 works fine here... using
>> arch/powerpc/configs/83xx/mpc8315_rdb_defconfig and
>> arch/powerpc/boot/dts/mpc8315erdb.dts
>> Hope this helps,
>>
> Thanks for the report, I went back to the defconfig and at least it
> gives me a partial boot:
>

False report. The partial boot was with a 2.6.24.7 dts, and 2.6.28 uImage.

After some experimenting, I noticed garbage on the serial port.

The pre-programmed u-boot is too old. The stupid thing is, I ran into
this earlier, the thread is here:

http://www.mail-archive.com/u-boot-users@lists.sourceforge.net/msg06551.html

I forgot I was using the second board lying around, which hadn't had
u-boot updated.

Regards,
-- 
Leon
