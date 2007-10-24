Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id A9033DDF2D
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 06:17:49 +1000 (EST)
Message-ID: <471FA875.6080602@ru.mvista.com>
Date: Thu, 25 Oct 2007 00:17:57 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: New time code miscalculates cpu usage
References: <20071016202525.GA11837@lixom.net>
In-Reply-To: <20071016202525.GA11837@lixom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Olof Johansson wrote:

> Not sure when this started happening, but I wanted to report it. I'll
> start bisecting in a day or two if noone else has gotten around to
> looking at it:

> $ echo "int main(void) { while(1); }" > test.c ; gcc test.c
> $ time ./a.out & sleep 2 ; killall a.out
> real    0m2.008s
> user    0m4.014s
> sys     0m0.002s
> 
> Seen on POWER5 and PA6T, haven't tried anything else yet.

    I'm not surprised -- the kernel accounts twice for each tick.

WBR, Sergei
