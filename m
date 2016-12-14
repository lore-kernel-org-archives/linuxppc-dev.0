Return-Path: <segher@gate.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdk6L4CwszDvhR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 15:26:18 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tdk6K2mlgz9t0H
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2016 15:26:16 +1100 (AEDT)
Date: Tue, 13 Dec 2016 22:25:46 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Joel Stanley <joel@jms.id.au>
Cc: Michael Ellerman <patch-notifications@ellerman.id.au>,
 gregkh@linuxfoundation.org, linuxppc-dev@ozlabs.org,
 markus@trippelsdorf.de, amodra@gmail.com
Subject: Re: powerpc: cmp -> cmpd for 64-bit
Message-ID: <20161214042546.GQ30845@gate.crashing.org>
References: <551528846e6a2783184ba8a4228348a2fc9786bd.1475761214.git.segher@kernel.crashing.org>
 <3t3mJS0hfYz9sxS@ozlabs.org>
 <CACPK8Xf3X=bEj-EUXezYYEKNJwkqW4O0RiM2FcCtH4cNNxA-qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACPK8Xf3X=bEj-EUXezYYEKNJwkqW4O0RiM2FcCtH4cNNxA-qw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 14, 2016 at 02:01:50PM +1030, Joel Stanley wrote:
> >> With older binutils this is silently accepted as if this was "cmpw",
> >> while often "cmpd" is wanted.  With newer binutils GAS will complain
> >> about this for 64-bit code.  For 32-bit code it still silently assumes
> >> "cmpw" is what is meant.

> This one made it into 4.9-rc3 as "powerpc: Convert cmp to cmpd in idle
> enter sequence". We need it to build the 4.4 kernel with GCC 6.2, so
> my OpenPower firmware builds are failing.

The GCC version does not matter; the binutils version does, however.


Segher
