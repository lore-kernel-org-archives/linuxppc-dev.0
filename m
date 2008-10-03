Return-Path: <jwboyer@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.235])
	by ozlabs.org (Postfix) with ESMTP id 0117EDE02D
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 22:26:54 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so693552wra.1
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Oct 2008 05:26:52 -0700 (PDT)
Date: Fri, 3 Oct 2008 08:25:40 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix a typo that breaks canyonland support
Message-ID: <20081003122540.GD2229@yoda.jdub.homelinux.org>
References: <20081003093338.50543DDF78@ozlabs.org>
	<20081003120441.GB2229@yoda.jdub.homelinux.org>
	<1223036286.12264.179.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1223036286.12264.179.camel@pasglop>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 03, 2008 at 10:18:06PM +1000, Benjamin Herrenschmidt wrote:
>On Fri, 2008-10-03 at 08:04 -0400, Josh Boyer wrote:
>> On Fri, Oct 03, 2008 at 07:33:20PM +1000, Benjamin Herrenschmidt wrote:
>> >A typo in the new ppc4xx_simple.c prevents proper detection of
>> >the AMCC Canyonland board.
>> >
>> >Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> 
>> This is already fixed in my 'next' branch.
>
>Ah well, I was waiting for you to ask me to pull it :-)

Today my friend.  Today.

I do try and at least test things a bit :).

josh
