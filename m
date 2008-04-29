Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 00FBBDE08F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 04:40:49 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] Add fast little-endian switch system call
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 29 Apr 2008 12:46:08 +1000."
	<18454.35824.527711.355488@cargo.ozlabs.ibm.com>
Date: Tue, 29 Apr 2008 20:40:47 +0200
Sender: wd@denx.de
Message-Id: <20080429184047.47CB7247B4@gemini.denx.de>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Christoph Hellwig <hch@lst.de>, mtk.manpages@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <18454.35824.527711.355488@cargo.ozlabs.ibm.com> you wrote:
> 
> > Am I missing something here or does this add a branch for every normal
> > syscall?
> 
> It does, but the impact is so small as to be unmeasurable with
> lmbench, even on the null syscall measurement.  The overhead of the
> easily-predicted not-taken branch is completely swamped by the amount
> of time that the sc and rfid instructions take.  I had it under a
> config option at one point but then decided not to bother with that
> when I couldn't measure any difference.

This probably depends a bit on  the  performance  of  the  system  in
question. Did you measure it - for example - on a 50 MHz MPC850 ?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
To get something done, a committee should consist  of  no  more  than
three men, two of them absent.
