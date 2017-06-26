Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwvMS6l0PzDr34
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 13:15:48 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paolo Abeni <pabeni@redhat.com>,
 Hannes Frederic Sowa <hannes@stressinduktion.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: DNS (?) not working on G5 (64-bit powerpc) (was [net-next, v3,
 3/3] udp: try to avoid 2 cache miss on dequeue)
In-Reply-To: <1498219181.2611.6.camel@redhat.com>
References: <87shisqihz.fsf@concordia.ellerman.id.au>
 <1498165026.2503.21.camel@redhat.com>
 <1498166297.111795.1018373424.5E414246@webmail.messagingengine.com>
 <87r2ybp4ud.fsf@concordia.ellerman.id.au>
 <1498219181.2611.6.camel@redhat.com>
Date: Mon, 26 Jun 2017 13:15:48 +1000
Message-ID: <87d19rphgb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paolo Abeni <pabeni@redhat.com> writes:
> Thank you!
>
> I'll submit formally the patch after some more testing.

Thanks.

> I noticed this version has entered the ppc patchwork, but I think that
> the formal submission should go towards the net-next tree.

Yeah it picks up all patches sent to the list. That's fine I'll just
mark it "Not applicable", and expect to see it arrive via net-next.

cheers
