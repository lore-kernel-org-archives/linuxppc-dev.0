Return-Path: <srs0=afag=ln=emerson.com=sachin.gosavi@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4217FL08yRzF36h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 13:26:30 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4217FK5BHxz8v3X
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 13:26:29 +1000 (AEST)
Received: from n7.nabble.com (n7.nabble.com [162.253.133.57])
 by ozlabs.org (Postfix) with ESMTP id 4217FK1Hmqz9ryt
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2018 13:26:28 +1000 (AEST)
Received: from n7.nabble.com (localhost [127.0.0.1])
 by n7.nabble.com (Postfix) with ESMTP id DB0886A42F6C
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2018 20:26:26 -0700 (MST)
Date: Wed, 29 Aug 2018 20:26:26 -0700 (MST)
From: sgosavi1 <Sachin.Gosavi@emerson.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1535599586827-0.post@n7.nabble.com>
In-Reply-To: <8ca7e76b239a14e322f00cd1a0eac141472ab2bd.camel@buserror.net>
References: <1535541276673-0.post@n7.nabble.com>
 <8ca7e76b239a14e322f00cd1a0eac141472ab2bd.camel@buserror.net>
Subject: Re: Not able to boot cuImage for the target board with MPC8270
 processor
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>  Are you sure the device tree you're using is correct for your board,
including 
>  all addresses being where your U-Boot configured them? 

I actually created one for the target board I am using but had similar
problem. So I decided to take the pq2fads.dts tree as a reference since it
is based on the POWER QUICKII family and build the cuImage. I am sure I will
get some errors here but I can debug and then build the device tree for my
board.

I will try to debug the boot wrapper code as suggested. Thanks for your
support.


Sachin.





--
Sent from: http://linuxppc.10917.n7.nabble.com/linuxppc-dev-f3.html
