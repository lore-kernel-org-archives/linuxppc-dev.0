Return-Path: <olof@lixom.net>
Received: from mail-we0-f172.google.com (mail-we0-f172.google.com
 [74.125.82.172])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 537E82C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 14:19:17 +1000 (EST)
Received: by mail-we0-f172.google.com with SMTP id w61so3924241wes.31
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Oct 2013 21:19:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1380792456-19128-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1380792456-19128-1-git-send-email-maddy@linux.vnet.ibm.com>
Date: Thu, 3 Oct 2013 21:19:13 -0700
Message-ID: <CAOesGMj6hWgJQ=hELJ9J1XTJnSTf+15FrxJuBZs=_U4RRMMB+g@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/kernel/sysfs: cleanup set up macros for
 PMC/non-PMC SPRs
From: Olof Johansson <olof@lixom.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 3, 2013 at 2:27 AM, Madhavan Srinivasan
<maddy@linux.vnet.ibm.com> wrote:
> Currently PMC (Performance Monitor Counter) setup macros are used
> for other SPRs. Since not all SPRs are PMC related, this patch
> modifies the exisiting macro and uses it to setup both PMC and
> non PMC SPRs accordingly.
>
> V3 changes:
>
> 1) No logic change, just renamed generic macro and removed #define for empty string
> 2) Changes in the comment to explain better.
>
> V2 changes:
>
> 1) Modified SYSFS_PMCSETUP to a generic macro with additional parameter
> 2) Added PMC and SPR macro to call the generic macro
> 3) Changes in the comment to explain better.
>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Acked-by: Olof Johansson <olof@lixom.net>

For the pa6t parts


-Olof
