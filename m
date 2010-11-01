Return-Path: <jwboyer@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id 894001007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 03:14:58 +1100 (EST)
Received: by wye20 with SMTP id 20so5771188wye.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 01 Nov 2010 09:14:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20101101.085126.71102684.davem@davemloft.net>
References: <AANLkTikQuUcAMZKqZ3Rz5HVzOs+63-Y4VYUo5-3EM30H@mail.gmail.com>
	<20101102023650.bc553e74.sfr@canb.auug.org.au>
	<AANLkTin3nsb6FfNtXfqjZCuV66mwKVOsKgmZpTABFDUJ@mail.gmail.com>
	<20101101.085126.71102684.davem@davemloft.net>
Date: Mon, 1 Nov 2010 12:14:55 -0400
Message-ID: <AANLkTi=MDPMXOPpvHXCBmEAWkRDcZN1u5h3H7J+ptrMq@mail.gmail.com>
Subject: Re: All Applied micro boards are failing with current mainline kernel
From: Josh Boyer <jwboyer@gmail.com>
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, eric.dumazet@gmail.com, rsarmah@apm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	therbert@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 1, 2010 at 11:51 AM, David Miller <davem@davemloft.net> wrote:
>> I can whip up a patch to remove those calls or move them after the
>> register, but I don't want to do that without knowing which one is
>> "right".
>
> I've already taken care of this.

Thanks!

josh
