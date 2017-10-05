Return-Path: <julia.lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7P0r23BwzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 07:06:16 +1100 (AEDT)
Date: Thu, 5 Oct 2017 22:06:11 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: =?ISO-8859-15?Q?Michal_Such=E1nek?= <msuchanek@suse.de>
cc: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jeremy Kerr <jk@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] powerpc/platforms/cell: Delete an error message for
 a failed memory allocation in three functions
In-Reply-To: <20171005220210.681f78e8@kitsune.suse.cz>
Message-ID: <alpine.DEB.2.20.1710052205560.2626@hadrien>
References: <db9efaf4-f3d7-d5dc-b0b2-f20e418fa3c8@users.sourceforge.net>
 <62146108-5be0-c236-f404-4be122e162ac@users.sourceforge.net>
 <20171005220210.681f78e8@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1723145302-1507233971=:2626"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--8323329-1723145302-1507233971=:2626
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Thu, 5 Oct 2017, Michal Suchánek wrote:

> Hello,
>
> On Thu, 5 Oct 2017 21:36:26 +0200
> SF Markus Elfring <elfring@users.sourceforge.net> wrote:
>
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Thu, 5 Oct 2017 21:04:30 +0200
> >
> > Omit extra messages for a memory allocation failure in these
> > functions.
>
> this is bogus. All these functions return -1 on any error. Until they
> reflect the error in their return value (and it is properly propagated
> to the user) there is no way to tell WTF failed without the message.

A backtrace will be generated.

julia

>
> >
> > This issue was detected by using the Coccinelle software.
> >
>
> ... which provides only a hint which should be evaluated by the user.
>
> Thanks
>
> Michal
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--8323329-1723145302-1507233971=:2626--
