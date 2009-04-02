Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 1C97DDDEE8
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 05:36:33 +1100 (EST)
Date: Thu, 2 Apr 2009 22:36:31 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Marcel Ziswiler <marcel@ziswiler.com>
Subject: Re: [PATCH] QE USB Host Integration for MPC832x
Message-ID: <20090402183631.GA6699@oksana.dev.rtsoft.ru>
References: <1238622396-9768-1-git-send-email-marcel@ziswiler.com>
	<20090402183357.GA29050@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090402183357.GA29050@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 02, 2009 at 10:33:57PM +0400, Anton Vorontsov wrote:
[...]
> > +			compatible = "fsl,mpc8360-qe-usb",
> 
> Ditto. No need for mpc8360 compatible.

Oh, I was wrong. fsl_qe_udc driver uses mpc8360 compatible for
matching, so you can't remove it. :-/

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
