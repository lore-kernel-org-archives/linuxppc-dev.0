Return-Path: <becky.bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23200DE006
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 07:27:12 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m8NLR7nO002720
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 14:27:07 -0700 (MST)
Message-Id: <3A595FB7-BB71-4BC7-9CA9-81BAD007FDDC@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <1222201125-15690-1-git-send-email-becky.bruce@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v5] POWERPC: Allow 32-bit hashed pgtable code to support
	36-bit physical
Date: Tue, 23 Sep 2008 16:27:05 -0500
References: <1222201125-15690-1-git-send-email-becky.bruce@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm an idiot - this broke the e500 build; new rev to follow.

-B
