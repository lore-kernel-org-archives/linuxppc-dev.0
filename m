Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F44E1A2354
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 16:34:43 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 7 Sep 2015 16:34:42 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C370C2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 16:34:40 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t876YW8v49414254
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Sep 2015 16:34:40 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t876Y8w3015304
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Sep 2015 16:34:08 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] cxl: abort cxl_pci_enable_device_hook() if PCI channel is
 offline
In-reply-to: <55ECD8C7.8040600@au1.ibm.com>
References: <1441347624-9787-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1441583849-sup-2488@delenn.ozlabs.ibm.com> <55ECD8C7.8040600@au1.ibm.com>
Date: Mon, 07 Sep 2015 16:33:43 +1000
Message-Id: <1441607471-sup-2948@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No worries. I've been caught out by something similar in the past when I
assumed that something like this:

if (foo)
	/*
	 * A big long
	 * multiline
	 * block comment!
	 */
	 do_something()

would surely already have curly brackets around it ;-)

Excerpts from andrew.donnellan's message of 2015-09-07 10:22:31 +1000:
> 
> On 07/09/15 09:58, Ian Munsie wrote:
> > Excerpts from andrew.donnellan's message of 2015-09-04 16:20:24 +1000:
> >> +    if (!cxl_adapter_link_ok(afu->adapter))
> >> +        dev_warn(&dev->dev, "%s: Device link is down, refusing to enable AFU\n", __func__);
> >> +        return false;
> >
> > Based on the indentation it looks like you meant to add some curly
> > brackets here.
> 
> Indeed I did, and I'd even thought I'd tested it... this is why I 
> shouldn't be allowed to submit patches at 4pm on Fridays...
> 
> Will submit V2.
> 
> (FWIW, I'm a firm believer in braces around single statements in 
> conditionals to avoid mistakes like this, but CodingStyle disagrees...)
> 
> 
> Andrew
> 
