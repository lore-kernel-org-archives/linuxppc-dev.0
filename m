Return-Path: <rcj@pochix.net>
Received: from mail-qa0-f42.google.com (mail-qa0-f42.google.com
 [209.85.216.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 91C1F2C0092
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2012 03:57:16 +1000 (EST)
Received: by qafi31 with SMTP id i31so1796032qaf.15
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2012 10:57:13 -0700 (PDT)
MIME-Version: 1.0
Sender: rcj@pochix.net
In-Reply-To: <501805C3.7030504@linux.vnet.ibm.com>
References: <1342630158-16510-1-git-send-email-olaf@aepfle.de>
 <1343611946.21647.23.camel@pasglop>
 <20120730190606.GD3155@aepfle.de> <1343704122.8227.3.camel@pasglop>
 <501805C3.7030504@linux.vnet.ibm.com>
Date: Tue, 31 Jul 2012 12:57:13 -0500
Message-ID: <CALAi6FdqR8Ljc75J76wu-SEwcSB1Zaz-eybq=DGdGkpxpNy90Q@mail.gmail.com>
Subject: Re: [PATCH] scsi/ibmvscsi: add module alias for ibmvscsic
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Brian King <brking@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Olaf Hering <olaf@aepfle.de>, Brian J King <bjking1@us.ibm.com>,
 linux-scsi@vger.kernel.org, "James E.J. Bottomley" <JBottomley@parallels.com>,
 linuxppc-dev@ozlabs.org, Robert C Jennings <rcjenn@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 31, 2012 at 11:20 AM, Brian King <brking@linux.vnet.ibm.com> wrote:
>
> On 07/30/2012 10:08 PM, Benjamin Herrenschmidt wrote:
> > On Mon, 2012-07-30 at 21:06 +0200, Olaf Hering wrote:
> >>> So while this would work, I do wonder however whether we could
> >> instead
> >>> fix it by simplifying the whole thing as follow since iSeries is now
> >>> gone and so we don't need split backends anymore:
> >>>
> >>> scsi/ibmvscsi: Remove backend abstraction
> >>
> >> I cant that these things myself anymore.
> >
> > Brian, can somebody from your side own these ?
>
> I talked to Rob and he will be picking this up. Rob - can you submit
> a patch to the maintainers file, adding yourself as the ibmvscsi
> maintainer?

I've submitted a patch for the MAINTAINERS file and I'll take a look at these
patches to verify them as well.  Thanks.

--Rob Jennings
