Return-Path: <rsa@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 42A8567B5F
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 05:15:29 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8BJFOJv022275
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Sep 2006 15:15:24 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8BJFO93244982
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Sep 2006 15:15:24 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8BJFOJM022216
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Sep 2006 15:15:24 -0400
Subject: Re: [PATCH] powerpc: Quiet hvc_console console output on failed opens
From: Ryan Arnold <rsa@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17664.43318.370252.157724@cargo.ozlabs.ibm.com>
References: <20060907151808.2295ad9a@localhost.localdomain>
	<1157661538.25088.235.camel@localhost.localdomain>
	<17664.43318.370252.157724@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 14:13:41 -0500
Message-Id: <1158002021.25088.245.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-09-08 at 09:20 +1000, Paul Mackerras wrote:
> Ryan Arnold writes:
> 
> > This seems like a good fix to me.  I think it is a debug artifact
> > anyway.
> 
> So, does that amount to an Acked-by?
> 
> Paul.

Yes, take that as an:

Acked-by: Ryan S. Arnold <rsa@us.ibm.com>

-- 
Ryan S. Arnold <rsa@us.ibm.com>
IBM Linux Technology Center
Linux on Power Toolchain
