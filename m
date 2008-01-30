Return-Path: <y-goto@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id 35018DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 12:13:54 +1100 (EST)
Date: Wed, 30 Jan 2008 10:13:05 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [-mm PATCH] updates for hotplug memory remove
In-Reply-To: <1201653101.19684.6.camel@dyn9047017100.beaverton.ibm.com>
References: <20080129120318.5BDF.Y-GOTO@jp.fujitsu.com>
	<1201653101.19684.6.camel@dyn9047017100.beaverton.ibm.com>
Message-Id: <20080130095002.4CCC.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Have you ever tested hotadd(probe) of the removed memory?
> 
> Yes. I did. In my touch testing, I was able to remove memory and add
> it back to the system without any issues.

Oh, really!?

> But again, I didn't force
> the system to use that memory :(

Ah..OK.

> 
> > I'm afraid there are some differences of the status between pre hot-add
> > section and the removed section by this patch. I think the mem_section of
> > removed memory should be invalidated at least.
> 
> I think its a generic issue. Nothing specific for ppc64. Isn't it ? 

Right.
Currently, our machine doesn't have real physical remove feature yet.
(only add).
So, I think testing is not enough around physical removing.
Probably, your box will be first one which can remove physical memory
with Linux. It is good for testing. 
If you notice anything, please let me know. :-)


Bye.

-- 
Yasunori Goto 
