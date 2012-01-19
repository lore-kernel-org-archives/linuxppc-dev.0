Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 by ozlabs.org (Postfix) with ESMTP id 3C8AAB6F13
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2012 20:34:16 +1100 (EST)
Date: Thu, 19 Jan 2012 10:34:05 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Matthias Fuchs <matthias.fuchs@esd.eu>
Subject: Re: Problem with full speed devices on PowerPC MPC5121 host port
Message-ID: <20120119103405.2256d750@wker>
In-Reply-To: <4F16CC3C.6060005@esd.eu>
References: <Pine.LNX.4.44L0.1201061258040.1326-100000@iolanthe.rowland.org>
 <4F1581E2.9030400@esd.eu> <20120118120811.04f7c601@wker>
 <4F16CC3C.6060005@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Matthias,

On Wed, 18 Jan 2012 14:42:20 +0100
Matthias Fuchs <matthias.fuchs@esd.eu> wrote:
...
> > Can you try the attached patch? Does it have an impact?
> 
> Yes, in deed, it solved my problem :-) Finally I noticed that
> the problem is listed in the CPU's errata document.
> 
> You could update the comment and commit message to "... when there is
> heavy simultaneus PATA write or network activity".
> 
> I vote for getting this mainline.
> 
> Tested-by: Matthias Fuchs <matthias.fuchs@esd.ue>

Thanks for testing! I'll rework to remove ifdef in the patch
and fix commit message and then resubmit.

Anatolij
