Return-Path: <tnt@246tNt.com>
Received: from outmx013.isp.belgacom.be (outmx013.isp.belgacom.be
	[195.238.5.64])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3C43A679FD
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 21:14:08 +1100 (EST)
Received: from outmx013.isp.belgacom.be (localhost [127.0.0.1])
	by outmx013.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kB5ADuJq017083
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Dec 2006 11:13:57 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4575463F.6070902@246tNt.com>
Date: Tue, 05 Dec 2006 11:13:19 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: master branch reset
References: <17780.2568.641734.276805@cargo.ozlabs.ibm.com>	<Pine.LNX.4.62.0612050839120.12448@pademelon.sonytel.be>	<528646bc0612042349t34662037nc641c8e6e2516a09@mail.gmail.com>	<Pine.LNX.4.62.0612050901160.12448@pademelon.sonytel.be>	<528646bc0612050015xa18b33bh4afdc2f9d196f1a1@mail.gmail.com>
	<Pine.LNX.4.62.0612051022470.20543@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0612051022470.20543@pademelon.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Apparently not :-(
>
> | pademelon$ git-reset --hard origin
> | pademelon$ git pull -v
> | Unpacking 10843 objects
> |  100% (10843/10843) done
> | * committish: ef6a3165e75c189da82c943a081cd1da52068738
> |   branch 'for-2.6.20' of git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
> | * refs/heads/for-2.6.20: same as branch 'for-2.6.20' of git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
> | * committish: e62438630ca37539c8cc1553710bbfaa3cf960a7
> |   branch 'master' of git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
> | * refs/heads/origin: does not fast forward to branch 'master' of git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc;
> |   not updating.
> | pademelon$
>   
try git pull -f -v
