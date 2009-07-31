Return-Path: <nvbolhuis@aimvalley.nl>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6ADD3B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 18:02:09 +1000 (EST)
Received: from smtp-vbr17.xs4all.nl (smtp-vbr17.xs4all.nl [194.109.24.37])
	by ozlabs.org (Postfix) with ESMTP id 9C349DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 18:02:07 +1000 (EST)
Message-ID: <4A72A4E5.1000301@aimvalley.nl>
Date: Fri, 31 Jul 2009 10:01:41 +0200
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: can the kernel show user task stack backtrace ?
References: <4A71C04E.6060506@aimvalley.nl>
	<20090730161941.GA14988@mail.gnudd.com>
	<20090730165555.GA5476@opentech.at>
In-Reply-To: <20090730165555.GA5476@opentech.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Nicholas Mc Guire <mcguire@lzu.edu.cn>,
	Alessandro Rubini <rubini@gnudd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Thanks for the answers!

libSegFault.so seems to do what I want. I'll replace
sysctl -w kernel.print-fatal-signals=1
with
export LD_PRELOAD=/lib/libSegFault.so
since it better suits my needs.
