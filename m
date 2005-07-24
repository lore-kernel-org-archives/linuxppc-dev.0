Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id 236CD67D08
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jul 2005 07:59:34 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i28so798599wra
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Jul 2005 14:59:33 -0700 (PDT)
Message-ID: <528646bc05072414596621b7ab@mail.gmail.com>
Date: Sun, 24 Jul 2005 15:59:33 -0600
From: Grant Likely <glikely@gmail.com>
To: Andrey Volkov <avolkov@varma-el.com>
In-Reply-To: <42E3DD39.8040104@varma-el.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <42DE89B1.1030400@integrian.com> <42E3DD39.8040104@varma-el.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: LITE5200 2.6.x kernel support
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/24/05, Andrey Volkov <avolkov@varma-el.com> wrote:
> Oliver,
>=20
> And, at this time, vanilla 2.6.xx kernel couldn't boot from nfs (and use
> eth too), since fec (ethernet) driver still not ready.

I believe that Sylvain's tree has FEC support in it, but that it
hasn't been pushed into mainline because the DMA engine hasn't been
ported to the platform bus yet.

http://ozlabs.org/pipermail/linuxppc-embedded/2005-June/018887.html

g.
