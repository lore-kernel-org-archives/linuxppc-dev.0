Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B2E71B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 09:56:38 +1000 (EST)
Received: from mail-yx0-f187.google.com (mail-yx0-f187.google.com
	[209.85.210.187]) by ozlabs.org (Postfix) with ESMTP id 13523DDD01
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Sep 2009 09:56:36 +1000 (EST)
Received: by yxe17 with SMTP id 17so476101yxe.9
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Sep 2009 16:56:34 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4A9F0377.1070606@embeddedarm.com>
References: <4A9F0377.1070606@embeddedarm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 2 Sep 2009 17:56:09 -0600
Message-ID: <fa686aa40909021656m1f14b428ued248f871ce4cbba@mail.gmail.com>
Subject: Re: PPC PCI bus registers
To: Eddie Dawydiuk <eddie@embeddedarm.com>
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

On Wed, Sep 2, 2009 at 5:44 PM, Eddie Dawydiuk<eddie@embeddedarm.com> wrote:
> Hello,
>
> I have a question regarding reading PCI bus registers from a user space
> application running on a PPC SBC. Seeing as though the PCI bus is little
> endian and PPC is big endian is it typical that one must perform a byte swap
> on all 16 and 32 bit register reads?

Yes, this is correct.

g.
