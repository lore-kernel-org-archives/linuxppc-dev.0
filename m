Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 764F4DDF47
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Apr 2007 20:47:18 +1000 (EST)
Date: Mon, 30 Apr 2007 12:47:14 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 13/14] powerpc: add ps3 platform system bus support
Message-ID: <20070430104714.GA25815@aepfle.de>
References: <4563D02F.9010307@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4563D02F.9010307@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 21, Geoff Levand wrote:

> Adds a PS3 system bus driver.  This system bus is a virtual bus used to present
> the PS3 system devices in the LDM.

What is the benefit of yet another bus?
Can those 3 drivers be platform devices instead?
The generated modalias files do not match anything.
