Return-Path: <hmurray@megapathdsl.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vGxcW3f9czDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 16:59:07 +1100 (AEDT)
Received: from ip-64-139-1-69.sjc.megapath.net
 (ip-64-139-1-69.sjc.megapath.net [64.139.1.69])
 by ozlabs.org (Postfix) with ESMTP id 3vGxcW0gwTz9ryj
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Feb 2017 16:59:05 +1100 (AEDT)
To: Frank Nicholas <frank@nicholasfamilycentral.com>
cc: Hal Murray <hmurray@megapathdsl.net>, Fred Wright <fw@fwright.net>,
 linuxppc-dev@ozlabs.org, devel@ntpsec.org
From: Hal Murray <hmurray@megapathdsl.net>
Subject: Re: Timekeeping oddities on MacMini G4s
In-Reply-To: Message from Frank Nicholas <frank@nicholasfamilycentral.com>
 of "Sun, 05 Feb 2017 10:36:38 EST."
 <92B558C5-B725-4F79-B6D5-1AACA4945263@nicholasfamilycentral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 Feb 2017 21:59:02 -0800
Message-Id: <20170206055902.EA5DE406061@ip-64-139-1-69.sjc.megapath.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Tell me what to look for, and I’ll take as many hi-res pictures as you want.

I'm looking for the frequency printed on the oscillator/crystal.

Here is a picture with several examples:
  https://en.wikipedia.org/wiki/File:Crystal_Packages.jpg

The row of Oscillators is most likely.  They also come in plastic packages.  
You will probably be able to see that they have 2 or 4 connections.  They 
will probably be quite a bit thicker than normal surface mount plastic 
packages.

Likely numbers are 166, 166.6 or an integer any sub multiple.  41.5 or 41.65 
is a good possibility.

-- 
These are my opinions.  I hate spam.
