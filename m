Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id D7E9BDE10C
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 08:21:38 +1100 (EST)
Message-ID: <45EF2CD8.3050804@ru.mvista.com>
Date: Thu, 08 Mar 2007 00:21:28 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 2/6 -rt] powerpc 2.6.20-rt8: to convert spinlocks to raw
	ones.
References: <yyi8xe925vg.wl@toshiba.co.jp>	<yyi649d25qz.wl@toshiba.co.jp>	<45EECE5C.6030100@ru.mvista.com>	<17902.60669.945986.186995@cargo.ozlabs.ibm.com>	<45EEF6A4.9090807@ru.mvista.com>
	<17903.4302.502364.126701@cargo.ozlabs.ibm.com>
In-Reply-To: <17903.4302.502364.126701@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Paul Mackerras wrote:

>>    As I said, this was intended for the -rt patch, hence the question was for 
>>Ingo. I CC'ed the list just to keep people here in a loop.

> OK, fair enough, but I still think the patch description was
> inadequate.  In the -rt context, I would at least expect to see some
> explanation as to why those particular locks needed to be converted.

    I've floowed up to my patch with such explanation. In the context of an-rt 
patch itself, it was just too clear, hence I didn't go into explanations in 
the patch itself. :-)

> Paul.

WBR, Sergei
