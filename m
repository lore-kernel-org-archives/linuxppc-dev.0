Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DEC24DDF01
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 07:42:30 +1000 (EST)
In-Reply-To: <1212180199-968-1-git-send-email-galak@kernel.crashing.org>
References: <1212180199-968-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <701fe7d26b27ceaffae6e3b77bf94cf7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Cleanup mpic nodes in .dts
Date: Fri, 30 May 2008 23:42:19 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Removed clock-frequency and big-endian props as they aren't specified
> anywhere.

If you remove "big-endian", you'll have to provide some other way
to get that information (like, some new "compatible" value).

Dunno if we need "clock-frequency".

This patch also removes "built-in" properties.  I'm all for that,
but the patch description didn't say it does.


Segher
