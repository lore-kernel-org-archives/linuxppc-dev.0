Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 952C3B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 15:30:06 +1000 (EST)
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.237])
	by ozlabs.org (Postfix) with ESMTP id 175AEDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 15:30:05 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so224687rvb.1
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 22:30:03 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC PATCH 0/3] Make 64-bit PCI device tree scanning code common
To: benh@kernel.crashing.org, galak@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Date: Thu, 20 Aug 2009 23:30:00 -0600
Message-ID: <20090821052714.2289.41279.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben and Kumar,

Compile tested only.  I haven't even tried to boot this on real
hardware, but I'm posting so that you guys can see what I'm up to.
Basically, I want access to the device tree scanning in ppc32 land,
and these patches start to get me there.  Please take a look and
comment.  Tomorrow I'll actually try running this stuff and debugging
the details.

Thanks,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
