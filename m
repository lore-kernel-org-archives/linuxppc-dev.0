Return-Path: <pnasrat@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 4443D679F4
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2006 03:43:18 +1100 (EST)
Subject: Re: yaboot 1.3.14 release candidate 1
From: Paul Nasrat <pnasrat@redhat.com>
To: Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <1139581305.5851.7.camel@grayson>
References: <1139538538.3638.14.camel@enki.eridu>
	<1139581305.5851.7.camel@grayson>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 11:43:15 -0500
Message-Id: <1140021795.2824.12.camel@enki.eridu>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-02-10 at 09:21 -0500, Ben Collins wrote:

> Not sure if you have anything like this in your tree at the moment, but
> here's a patch we use for Ubuntu. It's based in part on code in silo (I
> maintain silo upstream). Since the two are very close in code, this made
> sense :). Silo allows you to add an arch in the image stanza like:

No, thanks for passing this on to me it looks sane, I'll test a little
then probably commit.  Currently I've been doing this on macs with an
ofboot script checking 64-bit, but this is probably better.

Paul
