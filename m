Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 23CA0DDDF3
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 15:47:09 +1000 (EST)
Subject: Re: [patch 2/5] macintosh: qindfarm_smu_sat: semaphore to mutex
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: akpm@linux-foundation.org
In-Reply-To: <200805022034.m42KY3Wn013261@imap1.linux-foundation.org>
References: <200805022034.m42KY3Wn013261@imap1.linux-foundation.org>
Content-Type: text/plain
Date: Mon, 05 May 2008 15:44:47 +1000
Message-Id: <1209966287.21644.46.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, dwalker@mvista.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-05-02 at 13:34 -0700, akpm@linux-foundation.org wrote:
> From: Daniel Walker <dwalker@mvista.com>
> 
> Signed-off-by: Daniel Walker <dwalker@mvista.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
