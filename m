Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06C181A07E3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 07:10:18 +1100 (AEDT)
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 90B9714110C
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2015 07:10:17 +1100 (AEDT)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glppd-linuxppc64-dev@m.gmane.org>)
 id 1ZnBKE-0004Fi-SJ
 for linuxppc-dev@ozlabs.org; Fri, 16 Oct 2015 22:10:02 +0200
Received: from aorleans-552-1-114-80.w92-140.abo.wanadoo.fr ([92.140.185.80])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 22:10:02 +0200
Received: from christophe.jaillet by
 aorleans-552-1-114-80.w92-140.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 22:10:02 +0200
To: linuxppc-dev@ozlabs.org
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] powerpc/prom: Avoid reference to potentially freed memory
Date: Fri, 16 Oct 2015 22:09:10 +0200
Message-ID: <mvrlh7$mjr$1@ger.gmane.org>
References: <1444976055-19148-1-git-send-email-christophe.jaillet@wanadoo.fr>
 <1444989750.12954.4.camel@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <1444989750.12954.4.camel@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org,kernel-janitors@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 16/10/2015 12:02, Michael Ellerman a écrit :
> As the kbuild robot detected you have left an extra "}" here.
>
> I don't mind too much if you send patches that aren't compile tested, but you
> might save yourself some time by compiling them.

Sorry about it, and thanks for your patience.
IMHO, this should never happen and patches should be at least 
compile-tested.

I will be more careful and compile-test any new patch I submit.

CJ
