Return-Path: <olof@lixom.net>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0B1FDB7095
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 09:35:33 +1100 (EST)
Received: by wgbds10 with SMTP id ds10so1104964wgb.14
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2012 14:35:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120307223255.25669.42520.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
 <20120307223255.25669.42520.stgit@bhelgaas.mtv.corp.google.com>
Date: Wed, 7 Mar 2012 14:35:29 -0800
Message-ID: <CAOesGMiPJg1gbsq_iBc6_6JrOtTonSoic-gGudBNpmz2BEHv8g@mail.gmail.com>
Subject: Re: [PATCH v3 10/34] powerpc/PCI: allow reallocation on PA Semi
From: Olof Johansson <olof@lixom.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 7, 2012 at 2:32 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> We believe there's no reason to prevent reallocation on PA Semi, so
> revert to the default of "allow reallocation if necessary."
>
> CC: Olof Johansson <olof@lixom.net>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Tested-by: Olof Johansson <olof@lixom.net>
Acked-by: Olof Johansson <olof@lixom.net>
