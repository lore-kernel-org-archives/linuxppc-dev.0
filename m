Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 124B2DDF99
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 04:30:21 +1100 (EST)
Message-ID: <45EEF6A4.9090807@ru.mvista.com>
Date: Wed, 07 Mar 2007 20:30:12 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 2/6 -rt] powerpc 2.6.20-rt8: to convert spinlocks to raw
	ones.
References: <yyi8xe925vg.wl@toshiba.co.jp>	<yyi649d25qz.wl@toshiba.co.jp>	<45EECE5C.6030100@ru.mvista.com>
	<17902.60669.945986.186995@cargo.ozlabs.ibm.com>
In-Reply-To: <17902.60669.945986.186995@cargo.ozlabs.ibm.com>
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

>>    I've already sent a patch fixing this one (along with many others) a month 
>>ago:

>>http://ozlabs.org/pipermail/linuxppc-dev/2007-February/031164.html

>>    I wonder iof it was ever considered... :-/

> The entire patch description was just this:

>>Convert the spinlocks in the PowerPC interrupt related code into the raw ones,
>>also convert the PURR and PMC related spinlocks...

> which says what you did, but gives NO CLUE about why this might be a
> good thing to do - what problem it fixes or what desirable outcome it
> produces.  I will not apply patches with inadequate descriptions.

    As I said, this was intended for the -rt patch, hence the question was for 
Ingo. I CC'ed the list just to keep people here in a loop.

> Paul.

WBR, Sergei
