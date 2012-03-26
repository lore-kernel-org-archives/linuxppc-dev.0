Return-Path: <key@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 37C37B6EEF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2012 03:09:53 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Mon, 26 Mar 2012 12:09:48 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 0708438C8067
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2012 12:09:45 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2QG9hVr203640
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2012 12:09:44 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2QG9hu0004439
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2012 13:09:43 -0300
Message-ID: <1332778237.6578.3.camel@key-ThinkPad-W510>
Subject: Re: [PATCH 00/17] Platform Facilities Option and crypto accelerator
 driver
From: Kent Yoder <key@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Mon, 26 Mar 2012 11:10:37 -0500
In-Reply-To: <06B7F1E7-951D-4753-BE00-7B0C84BACDAE@kernel.crashing.org>
References: <1332365297.3858.5.camel@key-ThinkPad-W510>
 <C23F031B-1431-4E98-92DC-3EB7E31D2776@kernel.crashing.org>
 <1332443286.3858.70.camel@key-ThinkPad-W510>
 <06B7F1E7-951D-4753-BE00-7B0C84BACDAE@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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


> 
> From what I can tell this isn't ISA level instructions and thus should NOT be in arch/powerpc.  This should be moved into drivers/crypto

  That makes sense.  I'll move them over in my next submission.

Kent

> - k
