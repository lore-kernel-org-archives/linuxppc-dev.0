Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE003.bigfish.com (ch1ehsobe002.messaging.microsoft.com
	[216.32.181.182]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71B72B6F82
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 29 May 2011 04:10:00 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Andrey Gusev <ronne@list.ru>
Subject: Re: PROBLEM: 2.6.39 doesn't boot on POWER MAC
Date: Sat, 28 May 2011 18:09:52 +0000
Message-ID: <BANLkTinZd32+5b=3DdYknBCtQJT0qiNKcg@mail.gmail.com>
References: <4DE0AA62.4070909@list.ru>
In-Reply-To: <4DE0AA62.4070909@list.ru>
Content-Type: text/plain; charset="koi8-r"
MIME-Version: 1.0
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

On Sat, May 28, 2011 at 2:55 AM, Andrey Gusev <ronne@list.ru> wrote:
> Hi!
> A kernel 2.6.39 doesn't boot on my POWER MAC G4. =9AA kernel 2.6.38.6 wit=
h
> almost the same config boots without any problems.

Have you tried using git-bisect to isolate the commit that breaks?

--=20
Timur Tabi
Linux kernel developer at Freescale=
