Return-Path: <mort@bork.org>
Received: from darwin.bork.org (darwin.bork.org [IPv6:2001:470:1f05:998::1])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D2481A01BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 09:03:13 +1100 (AEDT)
Date: Mon, 2 Mar 2015 17:03:11 -0500
From: Martin Hicks <mort@bork.org>
To: Martin Hicks <mort@bork.org>
Subject: Re: [PATCH 0/2] crypto: talitos: Add AES-XTS mode
Message-ID: <20150302220311.GB30523@darwin.bork.org>
References: <1424451610-5786-1-git-send-email-mort@bork.org>
 <54F464E4.8080204@freescale.com>
 <20150302214419.GA30523@darwin.bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150302214419.GA30523@darwin.bork.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Milan Broz <gmazyland@gmail.com>,
 Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 02, 2015 at 04:44:19PM -0500, Martin Hicks wrote:
> 
> 			Write (MB/s)	Read (MB/s)
> Unencrypted		140		176
> aes-xts-plain64 512b	113		115
> aes-xts-plain64 4kB	71		56

I got the two AES lines backwards.  Sorry about that.

mh

-- 
Martin Hicks P.Eng.    |      mort@bork.org
Bork Consulting Inc.   |  +1 (613) 266-2296
