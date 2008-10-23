Return-Path: <jwboyer@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.236])
	by ozlabs.org (Postfix) with ESMTP id 0F227DDEE1
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 11:19:28 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id s6so23850wxc.15
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 17:19:27 -0700 (PDT)
Date: Wed, 22 Oct 2008 20:19:15 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: build failure on powerpc with current -git
Message-ID: <20081023001915.GA30920@zod.rchland.ibm.com>
References: <48F8E86B.702@nortel.com>
	<18685.27030.529655.761257@cargo.ozlabs.ibm.com>
	<20081021191324.d4810d40.sfr@canb.auug.org.au>
	<18686.42209.47915.184451@cargo.ozlabs.ibm.com>
	<fb412d760810220819o1a15d47ej198f6e15c3e63f15@mail.gmail.com>
	<48FF67E1.4070001@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48FF67E1.4070001@nortel.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Paul Mackerras <paulus@samba.org>,
	Linux kernel <linux-kernel@vger.kernel.org>,
	Hollis Blanchard <hollis@penguinppc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 22, 2008 at 11:50:25AM -0600, Chris Friesen wrote:
> Hollis Blanchard wrote:
>
>> binutils 2.16.1 is the most recent binutils that will build with  
>> crosstool, so IMHO it's worth supporting. :)
>
> I was wondering about that....wasted a bunch of time trying to build 
> something more recent.

I built binutils 2.18 for ppc, ppc no-float, ppc64, mips, and i386
yesterday.  It worked fine...

josh
