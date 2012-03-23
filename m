Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2FC75B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 03:07:07 +1100 (EST)
Subject: Re: [PATCH 00/17] Platform Facilities Option and crypto accelerator
 driver
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1332443286.3858.70.camel@key-ThinkPad-W510>
Date: Fri, 23 Mar 2012 11:06:50 -0500
Message-Id: <06B7F1E7-951D-4753-BE00-7B0C84BACDAE@kernel.crashing.org>
References: <1332365297.3858.5.camel@key-ThinkPad-W510>
 <C23F031B-1431-4E98-92DC-3EB7E31D2776@kernel.crashing.org>
 <1332443286.3858.70.camel@key-ThinkPad-W510>
To: Kent Yoder <key@linux.vnet.ibm.com>
Cc: rcj@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 22, 2012, at 2:08 PM, Kent Yoder wrote:

> Hi Kumar,
>=20
>> Is there a reason this isn't in drivers/crypto/
>=20
>  Other arch-specific dirs have their crypto subdir as well such as
> arch/s390.  I was just matching that.
>=20
> Kent
>=20
>> - k
>=20

=46rom what I can tell this isn't ISA level instructions and thus should =
NOT be in arch/powerpc.  This should be moved into drivers/crypto

- k=
