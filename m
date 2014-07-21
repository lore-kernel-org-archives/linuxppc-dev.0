Return-Path: <fabf@skynet.be>
Received: from mailsec108.isp.belgacom.be (mailsec108.isp.belgacom.be
 [195.238.20.104])
 by lists.ozlabs.org (Postfix) with ESMTP id 1B2A91A017D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 16:09:31 +1000 (EST)
Date: Mon, 21 Jul 2014 08:09:27 +0200 (CEST)
From: Fabian Frederick <fabf@skynet.be>
Reply-To: Fabian Frederick <fabf@skynet.be>
To: David Miller <davem@davemloft.net>
Message-ID: <1973473442.929183.1405922967308.open-xchange@webmail.nmp.skynet.be>
In-Reply-To: <20140720.213102.1007291311502673484.davem@davemloft.net>
References: <1405865801-18806-1-git-send-email-fabf@skynet.be>
 <20140720.213102.1007291311502673484.davem@davemloft.net>
Subject: Re: [PATCH 00/30] drivers/net: remove unnecessary break after return
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: brcm80211-dev-list@broadcom.com, e1000-devel@lists.sourceforge.net,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, joe@perches.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> On 21 July 2014 at 06:31 David Miller <davem@davemloft.net> wrote:
>
>
> From: Fabian Frederick <fabf@skynet.be>
> Date: Sun, 20 Jul 2014 16:16:08 +0200
>
> > Second patchset after "remove unnecessary break after goto" addressing break
> > redundancy on drivers/net branch
> > (suggested by Joe Perches)
>
> All applied except the i40e patch, which did not apply to net-next at all.

Thanks a lot David.

Fabian
