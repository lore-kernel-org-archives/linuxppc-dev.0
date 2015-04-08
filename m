Return-Path: <rbrito@ime.usp.br>
Received: from nm3-vm0.bullet.mail.bf1.yahoo.com
 (nm3-vm0.bullet.mail.bf1.yahoo.com [98.139.212.154])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 579811A0D1F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 10:37:39 +1000 (AEST)
Date: Tue, 7 Apr 2015 21:37:33 -0300
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Old regression with MTD devices disappearing from a Kurobox HD/HG
Message-ID: <20150408003638.GA5170@ime.usp.br>
References: <20150404054022.GA15572@ime.usp.br>
 <1428446044.22867.475.camel@freescale.com>
 <20150407235812.GA3443@ime.usp.br>
 <1428451332.22867.490.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1428451332.22867.490.camel@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Scott,

Once again, thank you very much for your answer.

On Apr 07 2015, Scott Wood wrote:
> On Tue, 2015-04-07 at 20:58 -0300, Rogério Brito wrote:
> > This is good to know. Is there any reasonable dts that I can copy/adapt?
> 
> I'm not familiar with how flash is connected on this chip, so I don't
> have a specific recommendation other than to read the binding and look
> at several examples.

How can I discover how the flash is connected? I'm really showing here that
I am only a luser, but I am willing to find any specs so that this can be
fixed.

> > Another question: would putting the description of the flash device into the
> > dts file be helpful to remove any code from the kernel?
> 
> If you currently have a custom flash map driver, you could get rid of
> that, but I suspect that's already gone away due to the fact that it's
> no longer working.

I see. If I do some "archaeology" (read: bisect when it stopped working),
would that help to discover how the flash is connected?


Thanks once again,

-- 
Rogério Brito : rbrito@{ime.usp.br,gmail.com} : GPG key 4096R/BCFCAAAA
http://cynic.cc/blog/ : github.com/rbrito : profiles.google.com/rbrito
DebianQA: http://qa.debian.org/developer.php?login=rbrito%40ime.usp.br
