Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E5353679E1
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 May 2006 01:22:01 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FaaDe-0004BH-CE
	for linuxppc-embedded@ozlabs.org; Mon, 01 May 2006 17:21:51 +0200
Received: from icarus.icarus.com ([64.105.89.2])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 01 May 2006 17:21:50 +0200
Received: from steve by icarus.icarus.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 01 May 2006 17:21:50 +0200
To: linuxppc-embedded@ozlabs.org
From: Stephen Williams <steve@icarus.com>
Subject: Re: PPC 405GPr support in linux 2.4.32
Date: Mon, 01 May 2006 08:21:14 -0700
Message-ID: <4456276A.9050405@icarus.com>
References: <e2ov5s$1hn$1@sea.gmane.org>
	<20060426163540.H16236@cox.net>	<20060427180743.GB11206@gate.ebshome.net>	<44510E4D.5040504@icarus.com>
	<20060430164013.GA4631@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <20060430164013.GA4631@dmt>
Sender: news <news@sea.gmane.org>
Cc: Willy Tarreau <willy@w.ods.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti wrote:
> Folks,
> 
> The v2.4 patch acceptance policy has been shifting gradually from
> "accept new features" to "critical fixes only", and at this point in
> time the goal is to have a minimal amount of modifications as possible.
> 
> There should be no need for major patch reworking with reference to new
> v2.4 releases.
> 
> Willy Tarreau created a repository of useful v2.4 patches for this sort
> of situations. Stephen, Eugene, I think the 405GPr patches are good candidates.
> 
> http://w.ods.org/linux/kernel/2.4/lkup/hardware.html

This (and things like it) needs to be *much* better advertised.
I had no idea it existed, or where I would look for such a thing.
It does no one any good if no one thinks to look for it;-)

If course the next major question is how does one submit patches
to this system?
-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
