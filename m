Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9444BB6F5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jun 2011 09:23:10 +1000 (EST)
In-Reply-To: <1308771051-30861-1-git-send-email-mike@mikebwilliams.com>
References: <1308771051-30861-1-git-send-email-mike@mikebwilliams.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <14e6cd940efae1704f5908757f81f627@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc,
	460gt: Add 460gt as compatible in the check for 460ex-compatible
	crypto
Date: Thu, 23 Jun 2011 01:24:54 +0200
To: Mike Williams <mike@mikebwilliams.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -	if (of_find_compatible_node(NULL, NULL, "amcc,ppc460ex-crypto")) {
> +	if (of_find_compatible_node(NULL, NULL, "amcc,ppc460ex-crypto") ||
> +	    of_find_compatible_node(NULL, NULL, "amcc,ppc460gt-crypto")) {

If the device is actually compatible, the device tree node should claim
it is, and you do not need this code change.


Segher
