Return-Path: <jk@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4CBB0DDF01
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 17:01:05 +1100 (EST)
From: Jeremy Kerr <jk@ozlabs.org>
To: michael@ellerman.id.au
Subject: Re: [PATCH] powerpc: Add write barrier before enabling DTL flags
Date: Tue, 24 Mar 2009 16:59:54 +1100
References: <1237863308.620048.912148989400.1.gpush@pingu>
	<1237874006.6478.284.camel@localhost>
In-Reply-To: <1237874006.6478.284.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200903241659.55302.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael,

> Wouldn't this still be a problem on a UP kernel?

I don't believe so - stores should be ordered with respect to the 
current CPU, and in the UP case we still get a barrier().

However, perhaps there are other considerations with the HV that I'm not 
aware of. Anyone?

Cheers,


Jeremy
