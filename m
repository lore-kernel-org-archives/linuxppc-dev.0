Return-Path: <srs0=sjbb=3u=gmail.com=ianjiang.cn@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2mmJ1GV4zDq8B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 11:38:56 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w2mmJ0CXRz8swW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 11:38:56 +1000 (AEST)
Received: from mbob.nabble.com (mbob.nabble.com [162.253.133.15])
 by ozlabs.org (Postfix) with ESMTP id 3w2mmH5TZDz9sNr
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2017 11:38:55 +1000 (AEST)
Received: from mtom.nabble.com (unknown [162.253.133.81])
 by mbob.nabble.com (Postfix) with ESMTP id 1412C40F98AF
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 18:38:14 -0700 (PDT)
Date: Tue, 11 Apr 2017 18:39:50 -0700 (MST)
From: IanJiang <ianjiang.cn@gmail.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1491961190461-121224.post@n7.nabble.com>
In-Reply-To: <1491903331.4166.240.camel@kernel.crashing.org>
References: <1491826953201-121121.post@n7.nabble.com>
 <20170410222442.GA11610@gwshan> <1491876268752-121154.post@n7.nabble.com>
 <1491876910.4166.219.camel@au1.ibm.com> <20170411044238.GA8157@gwshan>
 <1491902810921-121181.post@n7.nabble.com>
 <1491903331.4166.240.camel@kernel.crashing.org>
Subject: Re: EEH error in doing DMA with PEX 8619
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

On Tue, Apr 11, 2017 at 5:37 PM, Benjamin Herrenschmidt [via linuxppc]
<ml-node+s10917n121182h95@n7.nabble.com> wrote:

> Another possibility would be if the requests from the PLX have a 
> different initiator ID on the bus than the device you are setting up 
> the DMA for. 

Is there a way to check out the initiator ID in the driver? I'd like to make
sure of this.



--
View this message in context: http://linuxppc.10917.n7.nabble.com/EEH-error-in-doing-DMA-with-PEX-8619-tp121121p121224.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
