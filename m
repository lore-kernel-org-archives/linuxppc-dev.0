Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tY2h36tgGzDvh9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 00:35:47 +1100 (AEDT)
Subject: Re: [PATCH 1/1] serial/uuc_uart: Set shutdown timeout to CONFIG_HZ
 independent 2ms
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org
References: <1480953058-4958-1-git-send-email-alexander.stein@systec-electronic.com>
 <5845900B.5010108@tabi.org> <18303458.zhjk47K7B1@ws-stein>
From: Timur Tabi <timur@tabi.org>
Message-ID: <5846BEAF.3040003@tabi.org>
Date: Tue, 6 Dec 2016 07:35:43 -0600
MIME-Version: 1.0
In-Reply-To: <18303458.zhjk47K7B1@ws-stein>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Stein wrote:
> Okay, I was just wondering why the timeout is dependant on the timer tick.
> That didn't seem obvious to me.
> Rethinking about this, I would rather replace those lines with msleep instead.

What's wrong with leaving it as-is?  The code is five years old, and 
Freescale/NXP barely uses the QE any more.  I don't have access to any 
hardware to test any changes you would propose.
