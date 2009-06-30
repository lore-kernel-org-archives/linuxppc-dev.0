Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 12A8EB70BB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 10:12:33 +1000 (EST)
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.227])
	by ozlabs.org (Postfix) with ESMTP id D7B75DDF86
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 02:17:05 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id b25so84514rvf.9
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 09:17:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <29DC34A6B43468409F5A371CFE34E849D7EF7B@ex01.ads.ubidyne.de>
References: <29DC34A6B43468409F5A371CFE34E849D7EF7B@ex01.ads.ubidyne.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 30 Jun 2009 10:16:43 -0600
Message-ID: <fa686aa40906300916h3718e50er88e1408be25e21c0@mail.gmail.com>
Subject: Re: Direct MII connection between MPC8313 and VIRTEX FPGA
To: Frank Prepelica <Frank.Prepelica@ubidyne.com>
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

On Tue, Jun 30, 2009 at 2:35 AM, Frank
Prepelica<Frank.Prepelica@ubidyne.com> wrote:
>> What kernel version are you using?
>
> We are using kernel version 2.6.24. I've searched for "current speed" in =
version 2.6.28.7 and I've found that string.
>
>> Yes, you need to modify the DTB. =A0You have a back to back MII
>> connection, not a phy, so you do *not* want to have a PHY node in the
>> device tree.
>
> Hmm, but I do have a "PHY", don't I?. The "PHY" will be emulated in the F=
PGA. Of course, it's not a physical PHY but it should look like one.

No, it sounds like you don't.  If you've got a back-to-back MII
connection, then you can fix the link speed and you don't need to do
any form of PHY emulation.  ie. you don't need to wire up the MDIO
pins.

> So, do I really need the remove the complete PHY description in the DTB?

yes.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
