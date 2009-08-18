Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 84C44B7B74
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 10:16:20 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b2so1626285ana.32
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Aug 2009 17:16:17 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Mon, 17 Aug 2009 20:16:14 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix __flush_icache_range on 44x
Message-ID: <20090818001614.GG3095@hansolo.jdub.homelinux.org>
References: <20090817134136.GB8710@zod.rchland.ibm.com>
	<20090817160713.GE8710@zod.rchland.ibm.com>
	<1250545588.4861.5.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1250545588.4861.5.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 18, 2009 at 07:46:28AM +1000, Benjamin Herrenschmidt wrote:
>On Mon, 2009-08-17 at 12:07 -0400, Josh Boyer wrote:
>> 
>> Olof pointed out that we could probably do the iccci before the icbi loop and
>> just skip that loop entirely on 44x.  This is most certainly valid, but at
>> this particular moment I don't have time to try and reproduce the issue with
>> an alternative fix and I wanted to get _something_ out there to fix the issue.  
>> 
>> I suck for that, I know.
>
>Well, I can massage your patch if you want. The fact is, the icbi loop
>and iccci are definitely redundant :-)

You can if you'd like.  My biggest concern is getting time to recreate.  I
think I'll have time later in the week if you'd like to wait until then.
I simply didn't want to send out a patch that I wasn't sure fixed the issue.

josh
