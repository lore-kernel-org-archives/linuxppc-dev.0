Return-Path: <vwool@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6750A67BB7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Nov 2006 02:54:07 +1100 (EST)
Subject: Re: [PATCH] adding ROM chips to device tree
From: Vitaly Wool <vwool@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <528646bc0611020731g26198316y5e162fff487e416b@mail.gmail.com>
References: <20061102145539.f0b8657f.vwool@ru.mvista.com>
	<528646bc0611020731g26198316y5e162fff487e416b@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 18:53:58 +0300
Message-Id: <1162482838.2592.0.camel@barja>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> What about selecting driver; ie. CFI vs. non-CFI FLASH devices?
> (Although I'm not sure that it really matters).

It's all left for physmap to handle.

Vitaly
