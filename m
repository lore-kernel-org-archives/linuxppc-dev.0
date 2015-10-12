Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DEB61A0682
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 16:35:18 +1100 (AEDT)
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0E3521402B0
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2015 16:35:17 +1100 (AEDT)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glppd-linuxppc64-dev@m.gmane.org>)
 id 1ZlVWn-0001JR-Kk
 for linuxppc-dev@ozlabs.org; Mon, 12 Oct 2015 07:20:05 +0200
Received: from aorleans-552-1-114-80.w92-140.abo.wanadoo.fr ([92.140.185.80])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2015 07:20:05 +0200
Received: from christophe.jaillet by
 aorleans-552-1-114-80.w92-140.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2015 07:20:05 +0200
To: linuxppc-dev@ozlabs.org
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] powerpc/mpc5xxx: Use of_get_next_parent to simplify code
Date: Mon, 12 Oct 2015 07:05:11 +0200
Message-ID: <mvff27$jm4$1@ger.gmane.org>
References: <1444595260-3332-1-git-send-email-christophe.jaillet@wanadoo.fr>
 <alpine.DEB.2.02.1510112243420.2096@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
In-Reply-To: <alpine.DEB.2.02.1510112243420.2096@localhost6.localdomain6>
Cc: linux-kernel@vger.kernel.org,kernel-janitors@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 11/10/2015 22:44, Julia Lawall a écrit :
>
>> of_get_next_parent can be used to simplify the while() loop and
>> avoid the need of a temp variable.
> Can you do something with the loop in __of_translate_address, in
> drivers/of/address.c?  Is there not an iterator for this?
>
> julia
>

Hi Julia,

There does not seem to be any 'for_each_parent_of_node' or equivalent.

Best regards,
CJ
