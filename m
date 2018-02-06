Return-Path: <alexandre.belloni@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zbPHL0wnnzF0r2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Feb 2018 23:42:19 +1100 (AEDT)
Date: Tue, 6 Feb 2018 13:42:12 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, neelegup@linux.vnet.ibm.com,
 stable@vger.kernel.org
Subject: Re: rtc-opal: Fix handling of firmware error codes, prevent busy loops
Message-ID: <20180206124212.GQ3404@piout.net>
References: <1470102616-18346-1-git-send-email-stewart@linux.vnet.ibm.com>
 <20180206022646.GP3404@piout.net>
 <87bmh24rq0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87bmh24rq0.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/02/2018 at 16:22:47 +1100, Michael Ellerman wrote:
> > Just a note to let you know that this patch should have gone through my
> > tree but it was not sent to linux-rtc or me.
> 
> Sorry, I saw it had been languishing for a long time and assumed you'd
> missed it.
> 
> Happy to revert/rework it if you're not happy with it.
> 

No, that's fine. It's just that the commit title stands out when using
git log --oneline and that triggered my OCD ;)

> > I guess what happened is that Michael cleaned up the Linux PPC patchwork
> > queue.
> 
> Yeah I did.
> 
> In future I'll ping you if there's something that seems to have fallen
> through the cracks.
> 

Great thanks!


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
