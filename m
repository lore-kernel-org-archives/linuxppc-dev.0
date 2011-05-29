Return-Path: <ronne@list.ru>
Received: from smtp12.mail.ru (smtp12.mail.ru [94.100.176.89])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56510B6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 29 May 2011 17:36:53 +1000 (EST)
Message-ID: <4DE1F78C.4020203@list.ru>
Date: Sun, 29 May 2011 11:36:44 +0400
From: Andrey Gusev <ronne@list.ru>
MIME-Version: 1.0
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: PROBLEM: 2.6.39 doesn't boot on POWER MAC
References: <4DE0AA62.4070909@list.ru>
	<BANLkTinZd32+5b=3DdYknBCtQJT0qiNKcg@mail.gmail.com>
In-Reply-To: <BANLkTinZd32+5b=3DdYknBCtQJT0qiNKcg@mail.gmail.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: "paulus@samba.org" <paulus@samba.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

28.05.2011 22:09, Tabi Timur-B04825 пишет:
> On Sat, May 28, 2011 at 2:55 AM, Andrey Gusev<ronne@list.ru>  wrote:
>> Hi!
>> A kernel 2.6.39 doesn't boot on my POWER MAC G4.  A kernel 2.6.38.6 with
>> almost the same config boots without any problems.
> Have you tried using git-bisect to isolate the commit that breaks?
>
I didn't. It takes very long time. If nobody have ideas I will.
