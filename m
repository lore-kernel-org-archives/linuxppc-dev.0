Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BF5CCDDDF3
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 07:46:36 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n1QKi0RI018569
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 13:44:00 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n1QKkWQ5210386
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 13:46:32 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1QKkVIS018195
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 13:46:32 -0700
Date: Thu, 26 Feb 2009 15:46:14 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch
Message-ID: <20090226204614.GA25017@zod.rchland.ibm.com>
References: <1235621244.8805.340.camel@pasglop>
	<20090226112818.GF19612@zod.rchland.ibm.com>
	<1235680221.7388.17.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1235680221.7388.17.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 27, 2009 at 07:30:21AM +1100, Benjamin Herrenschmidt wrote:
>On Thu, 2009-02-26 at 06:28 -0500, Josh Boyer wrote:
>> On Thu, Feb 26, 2009 at 03:07:24PM +1100, Benjamin Herrenschmidt wrote:
>> >Hi Linus !
>> >
>> >Please pull a few regression fixes for powerpc.
>> >
>> >Cheers,
>> >Ben.
>> >
>> >The following changes since commit 169d418b127b98a3e464e9c4b807ad083760f98c:
>> >  Linus Torvalds (1):
>> >        Merge branch 'for-linus' of git://git.kernel.org/.../tiwai/sound-2.6
>> >
>> >are available in the git repository at:
>> >
>> >  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge
>> >
>> >Mark Nelson (2):
>> >      powerpc: Fix 64bit memcpy() regression
>> >      powerpc: Fix 64bit __copy_tofrom_user() regression
>> >
>> >Michael Neuling (1):
>> >      powerpc: Fix load/store float double alignment handler
>> 
>> You don't seem to have your fix for PCI 2.x stuff on 4xx here.  Patchwork
>> has it in accepted state and Geert has been asking if it would go in 2.6.29.
>> 
>> Any idea what is up with that one?
>
>This isn't a regression is it ? so it's a bit late now, have you checked

It's a regression from 2.6.28, yes.  See:

http://ozlabs.org/pipermail/linuxppc-dev/2009-February/067914.html

and

http://patchwork.ozlabs.org/patch/21527/

(note the Accepted state)

>if it's in my next or test branch ? I would have though it would have
>gone through your tree, maybe I missed it some way.

I can't find it in your tree anywhere.

josh
