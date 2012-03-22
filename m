Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 40819B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2012 04:17:32 +1100 (EST)
Subject: Re: [PATCH 00/17] Platform Facilities Option and crypto accelerator
 driver
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1332365297.3858.5.camel@key-ThinkPad-W510>
Date: Thu, 22 Mar 2012 12:17:08 -0500
Message-Id: <C23F031B-1431-4E98-92DC-3EB7E31D2776@kernel.crashing.org>
References: <1332365297.3858.5.camel@key-ThinkPad-W510>
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


On Mar 21, 2012, at 4:28 PM, Kent Yoder wrote:

> arch/powerpc/crypto/nx/Makefile             |   11 +
> arch/powerpc/crypto/nx/nx-aes-cbc.c         |  135 +++++
> arch/powerpc/crypto/nx/nx-aes-ccm.c         |  466 ++++++++++++++++++
> arch/powerpc/crypto/nx/nx-aes-ctr.c         |  175 +++++++
> arch/powerpc/crypto/nx/nx-aes-ecb.c         |  133 +++++
> arch/powerpc/crypto/nx/nx-aes-gcm.c         |  352 +++++++++++++
> arch/powerpc/crypto/nx/nx-aes-xcbc.c        |  230 +++++++++
> arch/powerpc/crypto/nx/nx-sha256.c          |  240 +++++++++
> arch/powerpc/crypto/nx/nx-sha512.c          |  259 ++++++++++
> arch/powerpc/crypto/nx/nx.c                 |  710 =
+++++++++++++++++++++++++++
> arch/powerpc/crypto/nx/nx.h                 |  190 +++++++
> arch/powerpc/crypto/nx/nx_csbcpb.h          |  246 +++++++++
> arch/powerpc/crypto/nx/nx_sysfs.c           |  194 ++++++++

Is there a reason this isn't in drivers/crypto/

- k=
