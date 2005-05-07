Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id 4A447679EB
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 May 2005 00:59:54 +1000 (EST)
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 06 May 2005 20:05:23 -0300."
	<20050506230523.GA15908@logos.cnet>
Date: Sat, 07 May 2005 16:59:40 +0200
Sender: wd@denx.de
Message-Id: <20050507145945.16751C1512@atlas.denx.de>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: fix usage of pinned 8Mbyte TLB entries 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050506230523.GA15908@logos.cnet> you wrote:
>
> > The BDI can, but other software functions will walk the page
> > tables looking for PTE information.  
> 
> Do you have any practical example which you are certain is going
> to break? 

I think the BDM4GDB BDM debugger depends  on  this,  and  maybe  some
other tools, too.

> I dont remember any, and I dont think any software should be walking
> kernel pte's directly...

Maybe not regular software, but debug tools  that  live  outside  the
kernel.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Testing can show the presense of bugs, but not their absence.
                                                   -- Edsger Dijkstra
