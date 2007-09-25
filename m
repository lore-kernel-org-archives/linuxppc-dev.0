Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 4FBE9DDECF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Sep 2007 01:19:47 +1000 (EST)
Date: Tue, 25 Sep 2007 10:22:44 -0500
From: Olof Johansson <olof@lixom.net>
To: Samuel Zahnd <samuel.zahnd@scs.ch>
Subject: Re: PaSemi DMA API for Linux
Message-ID: <20070925152244.GA31630@lixom.net>
References: <005401c7ff6f$d24ea290$4c0112ac@scsad.scs.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <005401c7ff6f$d24ea290$4c0112ac@scsad.scs.ch>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 25, 2007 at 02:30:13PM +0200, Samuel Zahnd wrote:
> Hi embedded people,
>  
> we have a PaSemi (PA6T-1682) CPU is use with Linux and CFE. I wonder if
> anybody has experience with the DMA engine of the device. Some examples or
> an API would be particularly usefull.

The network driver uses the DMA engine, besides that there's not much
example code out there.

The DMA has alot of features, just what are you looking to do? Just DMA
copy offload, or other functions?


-Olof
