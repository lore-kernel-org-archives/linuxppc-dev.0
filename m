Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id BBB93DDF2D
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 10:26:58 +1100 (EST)
To: Rob Gubler <rgubler@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Ebony DTS compile error
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <e4ef24880901271415q166a20e0m53d495c3dc2f80a3@mail.gmail.com>
References: <e4ef24880901231707y7baad5f6kc1f6bde2c30bf29f@mail.gmail.com>
	<20090124014701.71561832E425@gemini.denx.de>
	<20090126232028.GB10495@yookeroo.seuss>
	<e4ef24880901271415q166a20e0m53d495c3dc2f80a3@mail.gmail.com>
Date: Wed, 28 Jan 2009 00:26:48 +0100
Message-Id: <20090127232648.8B49C832E416@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Rob Gubler,

In message <e4ef24880901271415q166a20e0m53d495c3dc2f80a3@mail.gmail.com> you wrote:
>
> My only attachment to this kernel is it looks like the IPIPE and Xenomai
> patches have already been applied to the 2.6.24 kernel provided by ELDK
> 4.2.  In the past applying these patches for an x86 machine wasn't always a
> simple task.  I was hoping to save myself some time.

You will find that applying the Xenomai patches to our tree is really
straightforward. The last version that has received "official" support
(i. e was added to Xenomai mainline) is v2.6.28, and tested with our tree.

> What git URL / path do you recommend I use to clone the repository?  I found

http://git.denx.de/?p=linux-2.6-denx.git

> some instructions on rebuilding the ELDK from scratch (
> http://www.denx.de/wiki/view/DULG/ELDKRebuilding).   Are these the
> instructions I should be following?

Please see http://www.denx.de/wiki/view/DULG/LinuxConfiguration

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I have often regretted my speech, never my silence.
