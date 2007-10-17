Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 83248DDE3A
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 16:07:48 +1000 (EST)
Date: Wed, 17 Oct 2007 16:07:48 +1000
To: Olof Johansson <olof@lixom.net>
Subject: Re: New time code miscalculates cpu usage
Message-ID: <20071017060747.GF9814@bakeyournoodle.com>
References: <20071016202525.GA11837@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20071016202525.GA11837@lixom.net>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 16, 2007 at 03:25:25PM -0500, Olof Johansson wrote:
> Hi,
> 
> Not sure when this started happening, but I wanted to report it. I'll
> start bisecting in a day or two if noone else has gotten around to
> looking at it:
> 
> $ echo "int main(void) { while(1); }" > test.c ; gcc test.c
> $ time ./a.out & sleep 2 ; killall a.out
> real    0m2.008s
> user    0m4.014s
> sys     0m0.002s
> 
> Seen on POWER5 and PA6T, haven't tried anything else yet.

For what it's worth, this is my bug.  I suspected it, and git bisect
confirmed it.I have an ugly work around now, but hope to have something
better out tomorrow.

Thanks Olof.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
