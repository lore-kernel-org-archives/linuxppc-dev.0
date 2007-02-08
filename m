Return-Path: <bwarren@qstreams.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id BA86CDDED8
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Feb 2007 02:42:43 +1100 (EST)
Subject: Re: CLI for embedded system
From: Ben Warren <bwarren@qstreams.com>
To: pjmaiya <pjmaiya@signal-networks.com>
In-Reply-To: <011b01c74b81$5604ad80$4601a8c0@signet>
References: <29DC34A6B43468409F5A371CFE34E849091044@ex01.ads.ubidyne.de>
	<011b01c74b81$5604ad80$4601a8c0@signet>
Content-Type: text/plain
Date: Thu, 08 Feb 2007 10:42:39 -0500
Message-Id: <1170949359.14627.66.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Pjmaiya,

On Thu, 2007-02-08 at 18:32 +0530, pjmaiya wrote:
> Hi,
>    Can anybody give me link/built in package or source code for
> implmenting CLI for embedded system on linux. We have tried to
> implement our own CLI on linux(with bash shell as base), but it is
> massive work since we need to support Tab feature, history
> feature,help etc..

If you're looking for something to emulate Cisco's IOS shell, there's an
open source project called 'clish':  

http://sourceforge.net/projects/clish/

I haven't really used this myself, so can't recommend for or against.

regards,
Ben
