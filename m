Return-Path: <jwboyer@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.234])
	by ozlabs.org (Postfix) with ESMTP id E5609DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Sep 2008 22:09:30 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so1814717wra.1
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Sep 2008 05:09:28 -0700 (PDT)
Date: Tue, 2 Sep 2008 08:08:49 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Reserve syscall number 319
Message-ID: <20080902120824.GB2218@yoda.jdub.homelinux.org>
References: <20080902054941.77DA3DDDF0@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080902054941.77DA3DDDF0@ozlabs.org>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 02, 2008 at 03:48:45PM +1000, Benjamin Herrenschmidt wrote:
>Some stuff I'm working on that isn't released yet needs
>a syscall number but I can't say what it's for until I
>get permission to release it :-)
>
>In the meantime, it would be nice if a number could be set
>aside so the tools being developped to use that stuff don't
>all need to be updated when things are eventually released.
>
>Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>---
>
>I wonder if I'll get hanged for that one :-)

Is it a powerpc-specific syscall?  If so... ew?

josh
