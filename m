Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18010.48350.669221.255859@cargo.ozlabs.ibm.com>
Date: Mon, 28 May 2007 21:28:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Wang, Baojun" <wangbj@lzu.edu.cn>
Subject: Re: Is it possible to call a C function in
	transfer_to_handler(arch/ppc/kernel/entry.S)?
In-Reply-To: <380406375.32007@eyou.net>
References: <380406375.32007@eyou.net> <200705281730.39257.wangbj@lzu.edu.cn>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Nicholas McGuire <der.herr@hofr.at>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wang, Baojun writes:

>   I'm sorry to ask this topic in this mailling list. I've spend more than 2 
> days try to add a C function call in transfer_to_handler(in 
> arch/ppc/kernel/entry.S) like this:

It's not going to work, because the MMU is off at this point.  It will
explode as soon as the C code tries to touch any external variable.

Paul.
