Return-Path: <johnny.hacking@gmail.com>
Received: from mail-pz0-f176.google.com (mail-pz0-f176.google.com
	[209.85.222.176]) by ozlabs.org (Postfix) with ESMTP id 7CB58B7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Sep 2009 12:43:02 +1000 (EST)
Received: by pzk6 with SMTP id 6so1952968pzk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Sep 2009 19:43:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cb9ecdfa0909230820k6ebbd589o409e58e2d9b6740c@mail.gmail.com>
References: <cb9ecdfa0909222055x1d691698sb516b5b8f5f81d@mail.gmail.com>
	<87y6o6rvvc.fsf@macbook.be.48ers.dk>
	<cb9ecdfa0909230352w77a37f59h3c7f1e146121f9f6@mail.gmail.com>
	<87r5txrkfz.fsf@macbook.be.48ers.dk>
	<cb9ecdfa0909230820k6ebbd589o409e58e2d9b6740c@mail.gmail.com>
Date: Mon, 28 Sep 2009 10:43:00 +0800
Message-ID: <cb9ecdfa0909271943o6133f5c8r9b25a25140e7842f@mail.gmail.com>
Subject: Re: GPIO driver for MPC8313.
From: Johnny Hung <johnny.hacking@gmail.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kerne source I used now is 2.6.23 with MPC8313-erdb pached. I
think I should port 2.6.28 gpio function back to 2.6.23. Is it a
common way to implement it in the kernel I used or I should port
MPC8313-erdb pached to 2.6.28 opposite?

BRs, H. Johnny

2009/9/23 Johnny Hung <johnny.hacking@gmail.com>:
> Many thanks for your help. I will try it.
>
> 2009/9/23 Peter Korsgaard <jacmet@sunsite.dk>:
>>>>>>> "Johnny" =3D=3D Johnny Hung <johnny.hacking@gmail.com> writes:
>>
>> =A0Johnny> Thanks, got it. BTW, how to trigger GPIO level in user space
>> =A0Johnny> application? I also found
>> =A0Johnny> arch/powerpc/platforms/52xx/mpc52xx_gpio.c is a good
>> =A0Johnny> example. Any reply is appreciate.
>>
>> Through sysfs. See 'Sysfs Interface for Userspace' section of
>> Documentation/gpio.txt
>>
>> --
>> Bye, Peter Korsgaard
>>
>
