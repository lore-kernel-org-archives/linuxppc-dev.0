Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17903.12035.781782.317694@cargo.ozlabs.ibm.com>
Date: Thu, 8 Mar 2007 08:30:43 +1100
From: Paul Mackerras <paulus@samba.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [patch 2/6 -rt] powerpc 2.6.20-rt8: to convert spinlocks to raw
	ones.
In-Reply-To: <45EF2CD8.3050804@ru.mvista.com>
References: <yyi8xe925vg.wl@toshiba.co.jp> <yyi649d25qz.wl@toshiba.co.jp>
	<45EECE5C.6030100@ru.mvista.com>
	<17902.60669.945986.186995@cargo.ozlabs.ibm.com>
	<45EEF6A4.9090807@ru.mvista.com>
	<17903.4302.502364.126701@cargo.ozlabs.ibm.com>
	<45EF2CD8.3050804@ru.mvista.com>
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

>     I've floowed up to my patch with such explanation. In the context of an-rt 
> patch itself, it was just too clear, hence I didn't go into explanations in 
> the patch itself. :-)

Well, it might be clear, to you, now, with the context in your head.
But if such a patch is to go into a git tree, and somebody comes along
in 3 years time and wants to know exactly why you made that change
(and maybe that somebody is you :), then they will need more detail -
such as how you came to the conclusion that those locks and no others
needed to be changed, for instance.

At least give some of the reasoning behind your choice of which locks
to convert, so that in future, if the patch turns out to have
introduced a bug somehow, the person debugging it can either identify
that there was a flaw in your logic, or else understand something that
you have seen that they missed.

Paul.
