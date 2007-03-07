Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17903.4302.502364.126701@cargo.ozlabs.ibm.com>
Date: Thu, 8 Mar 2007 06:21:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [patch 2/6 -rt] powerpc 2.6.20-rt8: to convert spinlocks to raw
	ones.
In-Reply-To: <45EEF6A4.9090807@ru.mvista.com>
References: <yyi8xe925vg.wl@toshiba.co.jp> <yyi649d25qz.wl@toshiba.co.jp>
	<45EECE5C.6030100@ru.mvista.com>
	<17902.60669.945986.186995@cargo.ozlabs.ibm.com>
	<45EEF6A4.9090807@ru.mvista.com>
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

>     As I said, this was intended for the -rt patch, hence the question was for 
> Ingo. I CC'ed the list just to keep people here in a loop.

OK, fair enough, but I still think the patch description was
inadequate.  In the -rt context, I would at least expect to see some
explanation as to why those particular locks needed to be converted.

Paul.
