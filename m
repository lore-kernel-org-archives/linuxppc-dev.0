Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A418B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Mar 2011 05:32:08 +1100 (EST)
Received: by iwc10 with SMTP id 10so7043146iwc.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Mar 2011 11:32:05 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <AANLkTikgG5JHimq5a2OsgsH+z+WsHO3MO6OU1q6_DzgH@mail.gmail.com>
References: <201103170129.p2H1TXG5031586@hera.kernel.org>
	<1300661524.2402.19.camel@pasglop>
	<AANLkTikgG5JHimq5a2OsgsH+z+WsHO3MO6OU1q6_DzgH@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 21 Mar 2011 12:31:45 -0600
Message-ID: <AANLkTi=gdksERWfFJTfXG2GebXKq9BU0BNCZ=FdZL6Qk@mail.gmail.com>
Subject: Re: powerpc/pci: Make both ppc32 and ppc64 use sysdata for
	pci_controller
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Hugh Dickins <hughd@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[reposting part of private email exchange as penance for my sins...]

On Mon, Mar 21, 2011 at 12:22 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Sun, Mar 20, 2011 at 4:52 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> Grant, what in hell makes you believe that this patch was ok to
>> merge upstream without even my Ack ?
>>
>> Yes, I told you I agree with the -principle-, but I also need to -test-
>> and review it properly which I haven't had a chance to do (and it does
>> break G5s at least it seems from the reports we are getting). In any
>> case this is clearly -NOT- within the boundaries of your devicetree
>> "tree" and should have gone through powerpc-next.
>
> Sorry Ben, I did not intend to merge that patch. =A0Quite simply I
> accidentally included it in my devicetree/next branch when I pushed
> out a bunch of other PCI related patches in February, and I overlooked
> that it was still in there when I sent Linus the pull request. =A0It was
> a complete failure on my part. =A0I apologize and submit myself for the
> required flogging.

A flogging schedule will be posted on the bulletin board in the lunch
room.  Sorry for the trouble.

g.
