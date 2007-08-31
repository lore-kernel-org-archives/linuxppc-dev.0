Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id D2B9BDDF3D
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Sep 2007 01:29:05 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so149155anc
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 08:29:04 -0700 (PDT)
Message-ID: <fa686aa40708310829s344e825dxb1a6d5c3823fa999@mail.gmail.com>
Date: Fri, 31 Aug 2007 09:29:03 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	"Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] bootwrapper: In cuImage,
	print message for ENET devices not found in tree
In-Reply-To: <20070831042536.GL19271@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070830202618.9927.32588.stgit@trillian.cg.shawcable.net>
	<20070831024356.GA19271@localhost.localdomain>
	<fa686aa40708302114g77b916bftb01c14e1b3357506@mail.gmail.com>
	<20070831042536.GL19271@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/30/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> Sorry, I was misleading.  Scott moved the printf() into the if (devp)
> as you do, but *didn't* add the alternative warning message in the
> else.
>
> The reason for this is that Planetcore only supplies the first MAC
> address, and the bootwrapper must derive the addresses for all the
> ENETs from that.  That in turn means it is much more convenient to
> call fixup_mac_addresses() with more addresses than there are
> ethernets, so we don't want a warning message when that happens.

Okay, that makes sense.  I just found Scott's patch which does the
same, so I'll drop my version.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
