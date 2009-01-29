Return-Path: <daniel.ng1234@gmail.com>
Received: from mail-gx0-f20.google.com (mail-gx0-f20.google.com
	[209.85.217.20]) by ozlabs.org (Postfix) with ESMTP id 69560DDF37
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 11:42:33 +1100 (EST)
Received: by gxk13 with SMTP id 13so7412614gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 16:42:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <200901281050.44952.laurentp@cse-semaphore.com>
References: <547eba1b0901272104r69f80c88yf99bb009ff886688@mail.gmail.com>
	<200901281050.44952.laurentp@cse-semaphore.com>
Date: Thu, 29 Jan 2009 11:42:31 +1100
Message-ID: <547eba1b0901281642i7683e72fsd82233373d6bf858@mail.gmail.com>
Subject: Re: How to bring up fs_enet on 2.6.27?
From: Daniel Ng <daniel.ng1234@gmail.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for your help so far Laurent-

On Wed, Jan 28, 2009 at 8:50 PM, Laurent Pinchart
<laurentp@cse-semaphore.com> wrote:
>
> Make sure FS_ENET_HAS_FCC is set in your kernel configuration.

Yep, I've done that...

>
> [snip]
>
>> The fs_enet probe() function doesn't seem to get called (I had put a
>> panic() in it). Should it?
>
> Yes it should.

Ok, so it isn't being called. What code calls the fs_enet probe()
function? What could be the reason why this isn't being called? ie. do
I need to set something else?

Should the device just be available as 'eth2', so that I can do
'ifconfig eth2 192.168.1.33'?

Cheers,
Daniel
