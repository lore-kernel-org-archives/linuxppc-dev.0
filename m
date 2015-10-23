Return-Path: <thenzl@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A8CA1A103E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2015 00:40:13 +1100 (AEDT)
Subject: Re: [PATCH v6 18/37] cxlflash: Fix AFU version access/storage and add
 check
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>
References: <1445458134-63197-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1445458441-21416-1-git-send-email-mrochs@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Tomas Henzl <thenzl@redhat.com>
Message-ID: <562A38B8.3060705@redhat.com>
Date: Fri, 23 Oct 2015 15:40:08 +0200
MIME-Version: 1.0
In-Reply-To: <1445458441-21416-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21.10.2015 22:14, Matthew R. Ochs wrote:
> The AFU version is stored as a non-terminated string of bytes within
> a 64-bit little-endian register. Presently the value is read directly
> (no MMIO accessor) and is stored in a buffer that is not big enough
> to contain a NULL terminator. Additionally the version obtained is not
> evaluated against a known value to prevent usage with unsupported AFUs.
> All of these deficiencies can lead to a variety of problems.
>
> To remedy, use the correct MMIO accessor to read the version value into
> a null-terminated buffer and add a check to prevent an incompatible AFU
> from being used with this driver.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
> Reviewed-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Tomas Henzl <thenzl@redhat.com>

Tomas
