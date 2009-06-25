Return-Path: <kernelmailz@googlemail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C1A3BB6F56
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 20:51:16 +1000 (EST)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by ozlabs.org (Postfix) with ESMTP id E995FDDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 20:51:14 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so337865fga.16
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 03:51:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A42AE1A.1090107@freescale.com>
References: <abe8a1fd0906240244i6e33c260xadff5cf462df7b8c@mail.gmail.com>
	<D47FC871-1535-4DBF-8617-6EEA8C180484@kernel.crashing.org>
	<abe8a1fd0906241046x2e3ee7d5h6a6c0231086a6f0e@mail.gmail.com>
	<4A42AE1A.1090107@freescale.com>
Date: Thu, 25 Jun 2009 16:21:11 +0530
Message-ID: <abe8a1fd0906250351y1aadc153m9f52f65a5860a2ca@mail.gmail.com>
Subject: Re: 85xx Address space query
From: kernel mailz <kernelmailz@googlemail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So this means
when kernel gets interrupted by app which may be in PID=5 (say)
kernel translations for PID=0 remain valid ?
I am not able to follow Scott

-TZ

On Thu, Jun 25, 2009 at 4:22 AM, Scott Wood<scottwood@freescale.com> wrote:
> kernel mailz wrote:
>>
>> But If the app was running with PID=1, interrupt occurs, kernel code
>> gets executed in PID=1, how does the kernel handle this ? and goes
>> back to PID=0, since its translations are all in PID=0
>
> PID 0 is special, it's mappings are present regardless of the value of the
> PID register.
>
> -Scott
>
