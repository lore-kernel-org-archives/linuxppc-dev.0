Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp8450FBRzDrL5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 17:23:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Marcelo Cerri <marcelo.cerri@canonical.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, George Wilson <gcwilson@us.ibm.com>,
 Claudio Carvalho <cclaudio@br.ibm.com>,
 Paulo Flabiano Smorigo <pfsmorigo@br.ibm.com>, joy.latten@canonical.com,
 "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: sha1-powerpc: little-endian support
In-Reply-To: <20160928132718.GB31082@gallifrey>
References: <1474659116-4689-1-git-send-email-marcelo.cerri@canonical.com>
 <20160928131551.GA31082@gallifrey>
 <20160928132015.GA21312@gondor.apana.org.au>
 <20160928132718.GB31082@gallifrey>
Date: Tue, 04 Oct 2016 17:23:16 +1100
Message-ID: <87pong4oq3.fsf@concordia.ellerman.id.au>
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

Marcelo Cerri <marcelo.cerri@canonical.com> writes:

> [ Unknown signature status ]
> On Wed, Sep 28, 2016 at 09:20:15PM +0800, Herbert Xu wrote:
>> On Wed, Sep 28, 2016 at 10:15:51AM -0300, Marcelo Cerri wrote:
>> > Hi Herbert,
>> > 
>> > Any thoughts on this one?
>> 
>> Can this patch wait until the next merge window? On the broken
>> platforms it should just fail the self-test, right?
>
> Yes. It fails on any LE platform (including Ubuntu and RHEL 7.1).

How are you testing this? I thought I was running the crypto tests but
I've never seen this fail.

cheers
