Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4DDE8DDEFC
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 Apr 2007 20:52:04 +1000 (EST)
Date: Mon, 2 Apr 2007 14:51:55 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: matvejchikov@gmail.com
Subject: Re: MDIO bus description and bitbang property
Message-ID: <20070402145155.4f4e68ca@vitb.ru.mvista.com>
In-Reply-To: <8496f91a0703301215r77c8e838pa9cd88ddd639a170@mail.gmail.com>
References: <8496f91a0703301215r77c8e838pa9cd88ddd639a170@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 30 Mar 2007 23:15:47 +0400
"Matvejchikov Ilya" <matvejchikov@gmail.com> wrote:

> Hi all!
> 
> As I see it mpc82xx MDIO description given in DTS file contains several
> inaccuracies concerning 'bitbang' property. Thus, 'bitbang' is the property
> of MDIO bus, but not a device on the bus (PHY for ex.). I have changed
> fs_enet_of_init() a little bit. Does anyone require such a patch?

Sorry but I don't quite follow the logic upper. If you have a patch, pls send it to me CC this list and 
we'll get it discussed. 

Thanks.
-- 
Sincerely, 
Vitaly
