Return-Path: <bwarren@qstreams.com>
Received: from smtp105.biz.mail.re2.yahoo.com (smtp105.biz.mail.re2.yahoo.com
	[206.190.52.174]) by ozlabs.org (Postfix) with SMTP id 5731F67B7B
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 23:29:05 +1000 (EST)
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
From: Ben Warren <bwarren@qstreams.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <20060927165556.04c8d5d7@vitb.ru.mvista.com>
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 09:09:16 -0400
Message-Id: <1159362556.5555.30.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: bwarren@qstreams.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-09-27 at 16:55 +0400, Vitaly Bordug wrote:

> 
> I though about that approach, but saw somewhere a reference that we should not summon new node types without utter necessity, and utilized memory because bcsr is memory-mapped stuff. I can hardly imagine bcsr as a device (which would require respective spec inclusion btw).
> 
> hence let's open a discussion what others think about that. The problem seems common (and for some boards 
> is called somewhat else apparently), but at this point we should come to some conclusion, document it, and use it.
> 
Since "memory" is not quite specific enough, but "board-control" is a
little bit Freescale and application-centric, how about
"memmapped-device", or something like that.  This could encompass FPGAs,
ASICs, CPLDs or anything else that is memory mapped.  Many custom
embedded boards have lots of such devices and could benefit from this
approach.

regards,
Ben
