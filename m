Return-Path: <mikey@neuling.org>
To: paulus@samba.org
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] minor POWER6 cputable cleanup 
In-reply-to: <9201.1169432486@neuling.org> 
References: <9201.1169432486@neuling.org>
Date: Mon, 22 Jan 2007 17:45:24 +1100
Message-ID: <31286.1169448324@neuling.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Merge CPU_FTR_POWER6 and CPU_FTR_POWER6X definitions.

After talking to paulus offline, it looks like POWER6X isn't being used.
I'll post a new patch to remove it.

Mikey
