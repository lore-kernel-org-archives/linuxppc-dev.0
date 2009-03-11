Return-Path: <lebon@lebon.org.ua>
Received: from b-mail.com.ua (b-mail.com.ua [195.68.202.242])
	by ozlabs.org (Postfix) with ESMTP id 6E997DE114
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 19:28:51 +1100 (EST)
Message-ID: <49B77683.8060401@lebon.org.ua>
Date: Wed, 11 Mar 2009 10:29:55 +0200
From: Mikhail Zolotaryov <lebon@lebon.org.ua>
MIME-Version: 1.0
To: Valentine <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC 440EPx/GRx fix memory size calculation
References: <20090310195013.GA27835@ru.mvista.com>
	<49B6D427.5050600@lebon.org.ua> <49B7167C.9000004@ru.mvista.com>
In-Reply-To: <49B7167C.9000004@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine wrote:
> The problem is that the controller is hardwired to use only one 
> chipselect, even if both are enabled in the DDR0_10 on PPC440EPx/GRx 
> processors.
>
It's new information for me. Is this problem described by some ERRATA or 
manual, could you please point me to the document (and page) ?
