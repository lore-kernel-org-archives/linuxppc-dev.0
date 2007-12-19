Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 34277DDEDB
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 07:46:41 +1100 (EST)
Date: Wed, 19 Dec 2007 23:48:53 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 0/4] device_type/compatible cleanups
Message-ID: <20071219204853.GA20972@localhost.localdomain>
References: <20071219203447.GA18285@localhost.localdomain>
	<47698054.1060909@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47698054.1060909@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 19, 2007 at 02:34:28PM -0600, Scott Wood wrote:
> Anton Vorontsov wrote:
> >Scott, I didn't add "fsl,cpm-muram" stuff, it just doesn't make
> >sense now: qe and cpm anyway using different code base.
> 
> That should change.

Sure. When that will change, then it will be sane to change the users,
I think. ;-) Not the vice versa.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
