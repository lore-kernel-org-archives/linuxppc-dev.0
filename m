Return-Path: <mchehab@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 9D504B6FE3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2012 00:02:56 +1000 (EST)
Message-ID: <4F9D49DC.6090002@redhat.com>
Date: Sun, 29 Apr 2012 11:02:04 -0300
From: Mauro Carvalho Chehab <mchehab@redhat.com>
MIME-Version: 1.0
To: Borislav Petkov <bp@amd64.org>
Subject: Re: [PATCH EDACv16 1/2] edac: Change internal representation to work
 with layers
References: <1335289087-11337-1-git-send-email-mchehab@redhat.com>
 <1335291342-14922-1-git-send-email-mchehab@redhat.com>
 <20120427133304.GE9626@aftab.osrc.amd.com> <4F9ADCE3.2030506@redhat.com>
 <20120428091621.GE26065@aftab.osrc.amd.com>
 <1335632874.4191.8.camel@joe2Laptop>
In-Reply-To: <1335632874.4191.8.camel@joe2Laptop>
Content-Type: text/plain; charset=UTF-8
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>,
 Jason Uhlenkott <juhlenko@akamai.com>, Aristeu Rozanski <arozansk@redhat.com>,
 Hitoshi Mitake <h.mitake@gmail.com>, Mark Gross <mark.gross@intel.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Egor Martovetsky <egor@pasemi.com>,
 =?UTF-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= <niklas.soderlund@ericsson.com>,
 Tim Small <tim@buttersideup.com>, "Arvind R." <arvino55@gmail.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Joe Perches <joe@perches.com>,
 Doug Thompson <norsk5@yahoo.com>,
 Linux Edac Mailing List <linux-edac@vger.kernel.org>,
 Michal Marek <mmarek@suse.cz>, Jiri Kosina <jkosina@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em 28-04-2012 14:07, Joe Perches escreveu:
> On Sat, 2012-04-28 at 11:16 +0200, Borislav Petkov wrote:
>> On Fri, Apr 27, 2012 at 02:52:35PM -0300, Mauro Carvalho Chehab wrote:
>>>> All those local variables should be sorted in a reverse christmas tree
>>>> order:
>>>>
>>>> 	u32 this_is_the_longest_array_name[LENGTH];
>>>> 	void *shorter_named_variable;
>>>> 	unsigned long size;
>>>> 	int i;
>>>>
>>>> 	...
>>>
>>> Why? There's nothing at the CodingStyle saying about how the vars should
>>> be ordered. If you want to enforce some particular order, please do it
>>> yourself, but apply it consistently among the entire subsystem.
>>
>> First of all, this way it is more readable.
> 
> Not in my opinion, and blindly using "reverse christmas tree"
> can separate variables that should be declared together.

I agree with Joe. The order won't make the code easier or harder to
read, nor it would improve code performance.

>> Second of all, maybe we should hold it down in CodingStyle.

Different developers have different opinions about how to order includes, 
functions, vars, etc. 

So, this is not at CodingStyle because there's no consensus about it, and 
because this is not relevant for code understanding.

A reviewer should not reject a patch just because he doesn't like the
order that the developer used.

Regards,
Mauro
