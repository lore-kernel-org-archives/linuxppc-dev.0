Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id F40CD67A64
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Apr 2005 01:37:05 +1000 (EST)
Message-ID: <42691A14.8060001@mvista.com>
Date: Fri, 22 Apr 2005 08:36:52 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Sam Song <samlinuxppc@yahoo.com.cn>
References: <20050422023020.98562.qmail@web15803.mail.cnb.yahoo.com>
In-Reply-To: <20050422023020.98562.qmail@web15803.mail.cnb.yahoo.com>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8245 custom board, Linux 2.4 kernel hangs after uncompressing
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sam Song wrote:

>had, is it possible to flush the content of __log_buf
>after reset?
>

Sam,

I thought I finally noticed yesterday that you're using 2.4. If that is
the case, you want to dump "log_buf" not "__log_buf".

Mark
