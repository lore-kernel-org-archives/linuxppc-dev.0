Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.211.195]) by ozlabs.org (Postfix) with ESMTP id 4C4FCB7D80
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 04:25:49 +1000 (EST)
Received: by ywh33 with SMTP id 33so4802341ywh.11
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 11:25:47 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <hv8ua6$uq0$1@dough.gmane.org>
References: <1276154181-25534-1-git-send-email-dbaryshkov__1637.54533646188$1276154215$gmane$org@gmail.com>
	<hv8ua6$uq0$1@dough.gmane.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 16 Jun 2010 12:25:27 -0600
Message-ID: <AANLkTilDO4Q_pXHux71Cr34EQsso-8kAd1ce7q2ATrCd@mail.gmail.com>
Subject: Re: [PATCH v2] lite5200: fix ethernet phy address
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 15, 2010 at 4:19 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Dmitry Eremin-Solenikov wrote:
>
>> According to my schematics, on Lite5200 board ethernet phy uses address
>> 0 (all ADDR lines are pulled down). With this change I can talk to
>> onboard phy (LXT971) and correctly use autonegotiation.
>
> What about this patch?

It was included in my merge req to Linus yesterday.

g.
