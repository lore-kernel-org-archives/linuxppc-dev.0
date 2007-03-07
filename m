Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17902.60669.945986.186995@cargo.ozlabs.ibm.com>
Date: Thu, 8 Mar 2007 03:49:01 +1100
From: Paul Mackerras <paulus@samba.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [patch 2/6 -rt] powerpc 2.6.20-rt8: to convert spinlocks to raw
	ones.
In-Reply-To: <45EECE5C.6030100@ru.mvista.com>
References: <yyi8xe925vg.wl@toshiba.co.jp> <yyi649d25qz.wl@toshiba.co.jp>
	<45EECE5C.6030100@ru.mvista.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov writes:

>     I've already sent a patch fixing this one (along with many others) a month 
> ago:
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2007-February/031164.html
> 
>     I wonder iof it was ever considered... :-/

The entire patch description was just this:

> Convert the spinlocks in the PowerPC interrupt related code into the raw ones,
> also convert the PURR and PMC related spinlocks...

which says what you did, but gives NO CLUE about why this might be a
good thing to do - what problem it fixes or what desirable outcome it
produces.  I will not apply patches with inadequate descriptions.

Paul.
