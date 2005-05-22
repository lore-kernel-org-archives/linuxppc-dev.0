Return-Path: <vroopcha@mcw.edu>
Received: from post.its.mcw.edu (post.its.mcw.edu [141.106.32.10])
	by ozlabs.org (Postfix) with ESMTP id 2C041679E2
	for <linuxppc-dev@ozlabs.org>; Mon, 23 May 2005 04:49:41 +1000 (EST)
Message-ID: <46853.65.25.183.227.1116781953.squirrel@webmail.mcw.edu>
In-Reply-To: <1115356511.28075.5.camel@gaston>
References: <42784801.7080105@gmail.com>
	<1115251597.7567.163.camel@gaston><427AE616.1030908@gmail.com>
	<1115356511.28075.5.camel@gaston>
Date: Sun, 22 May 2005 12:12:33 -0500 (CDT)
From: "vinai" <vroopcha@mcw.edu>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Oops in snd-powermac on powerbook 3400
Reply-To: vroopcha@mcw.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Thu, 2005-05-05 at 23:35 -0400, Keenan Pepper wrote:
>> I fixed it!
>>
>> I changed it to use the same device node for sound as for
>> chip->node, and it started beeping at me! Apparently sometime
>> between 2.6.8 and 2.6.12-rc3 the KIOCSOUND ioctl was implemented,
>> because it sure didn't beep before.
>>
>> BTW, this is the first time I've ever fixed a kernel bug.
>
> Ok, I think your patch was whitespace damaged, so I re-did it by hand
> ;)
>
> Here's the result. Please test. Also, other people around, please test
> if with this patch, snd-powermac works, especially on oldworld
> machines!
>
> I'll submit upstream tomorrow hopefully.
>
> Ben.

My apologies for only now replying to this, but I can confirm the patch
that originally accompanied the above e-mail also worked fine on my
8500, I'm listening to an audio CD as I type this ;-)

I just got back to playing around, and patched 2.6.11 up to 2.6.12-rc4
and did not see this patched included, so I thought I'd try to include
it myself locally.  Nice work all :)

cheers
vinai
