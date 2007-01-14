Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A26ADDE3B
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 11:30:24 +1100 (EST)
In-Reply-To: <11687326992407-git-send-email-grant.likely@secretlab.ca>
References: <11687326992407-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <84dba8e3e19d453c2961c4022ddb77de@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Make it blatently clear;
	5200 device tree is not yet stable
Date: Sun, 14 Jan 2007 01:31:00 +0100
To: grant.likely@secretlab.ca
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Please apply for 2.6.20.  This is documentation only, but I don't want
> to give people false assumptions about the stability of the 5200 device
> tree bindings

Good idea.

> +********** DRAFT ***********
> +* WARNING: Do not depend on definiton remaining static between
> +* kernel versions.  The 5200 device tree conventions are still in flux
> +* and could change without notice.  Keep an eye on the linuxppc-dev
> +* mailing list for more details
> +*
> +* Hopefully by 2.6.21 it will be stable.  ---gcl, Jan 13, 2007
> +********** DRAFT ***********

But could you please rephrase in a way that doesn't suggest
the *kernel* defines what the device bindings are?  They are
only documented in the kernel tree right now, sure, but that's
not the same thing ;-)


Segher
