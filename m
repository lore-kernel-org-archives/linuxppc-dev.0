Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 by ozlabs.org (Postfix) with ESMTP id DA2802C0330
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2013 11:38:28 +1100 (EST)
Date: Sun, 3 Feb 2013 16:38:21 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: 3.7-rc7: BUG: MAX_STACK_TRACE_ENTRIES too low!
In-Reply-To: <alpine.DEB.2.01.1301271451390.7378@trent.utfs.org>
Message-ID: <alpine.DEB.2.01.1302031635410.13050@trent.utfs.org>
References: <alpine.DEB.2.01.1211271824120.7378@trent.utfs.org>
 <alpine.DEB.2.01.1211271916160.7378@trent.utfs.org>
 <1354092082.3054.19.camel@ThinkPad-T5421.cn.ibm.com>
 <alpine.DEB.2.01.1301121241340.7378@trent.utfs.org>
 <1358233164.15371.2.camel@ThinkPad-T5421.cn.ibm.com>
 <alpine.DEB.2.01.1301271451390.7378@trent.utfs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 27 Jan 2013 at 14:56, Christian Kujau wrote:
> Hm, is there no chance to get this into 3.8? I've been running with this 
> patch applied since 3.7-rc7 and it got rid of this 
> "MAX_STACK_TRACE_ENTRIES too low" message. I've just upgraded to 3.8-rc5 
> and it's still not in mainline :-\

Hah! I just noticed that it got merged the next day - Thanks!

Christian.
-- 
BOFH excuse #80:

That's a great computer you have there; have you considered how it would work as a BSD machine?
