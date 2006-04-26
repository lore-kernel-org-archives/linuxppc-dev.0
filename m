Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AC7EF679EF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Apr 2006 09:57:36 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYtst-0002YR-CY
	for linuxppc-embedded@ozlabs.org; Thu, 27 Apr 2006 01:57:27 +0200
Received: from icarus.icarus.com ([64.105.89.2])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 27 Apr 2006 01:57:27 +0200
Received: from steve by icarus.icarus.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 27 Apr 2006 01:57:27 +0200
To: linuxppc-embedded@ozlabs.org
From: Stephen Williams <steve@icarus.com>
Subject: Re: PPC 405GPr support in linux 2.4.32
Date: Wed, 26 Apr 2006 16:57:21 -0700
Message-ID: <445008E1.70404@icarus.com>
References: <e2ov5s$1hn$1@sea.gmane.org> <20060426163540.H16236@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <20060426163540.H16236@cox.net>
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matt Porter wrote:
> On Wed, Apr 26, 2006 at 04:19:23PM -0700, Stephen Williams wrote:
>> ... seems completely missing in the linux-2.3.32 tree from kernel.org.
>> This used to be in the linuxppc-2.4 BK tree that no longer exists, so
>> what happened to the ppc405GPr support?!
> 
> There's some stuff that never got submitted upstream to kernel.org
> during 2.4 due partially to 2.5 appearing. All upstream devel
> moved to 2.5/2.6 and no effort was made to merge stuff from the
> linuxppc-2.4 tree to linux-2.4. Oh, and Marcelo didn't want
> to take "new stuff" into linux-2.4 at that time either.
> 
> There's still rsync://source.mvista.com/linuxppc-2.4 available with
> the 405gpr/sycamore support.

Well then I guess for 405GPr support and the SystemACE drivers
I'm on my own. Is there a git tree for main line 2.4 maintenance
(against which I could maintain patches) or am I on my own there
too?

It should be easy enough to rescue the gpr support form the bk
working dir that I have (or the mvista repository as you point
out) and make up patches.
-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
