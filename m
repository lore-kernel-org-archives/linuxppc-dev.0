Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 66D1167B9B
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Nov 2006 05:47:15 +1100 (EST)
Date: Wed, 29 Nov 2006 12:45:11 -0600
From: Olof Johansson <olof@lixom.net>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH] ppc64_defconfig to use AUTOFS_V4 not V3
Message-ID: <20061129124511.3be6b9a8@localhost.localdomain>
In-Reply-To: <20061129180522.GM10879@austin.ibm.com>
References: <20061129180522.GM10879@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, nfonteno@us.ibm.com,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 29 Nov 2006 12:05:22 -0600 linas@austin.ibm.com (Linas Vepstas) wrote:

> Please apply. Although I have a general question: who is served
> by the ppc64_defconfig these days? Any reason why its not more 
> like powerpc_defcofig?  "make defconfig" uses uname -m to pick up
> the defconfig, and my cell, rhel5 and sles10 boxes report ppc64 
> not pseries for uname -m.  

I like using it to build a kernel that runs on as much as possible with
a single image, but I don't think all platforms have been added there
(yet). Sort of like a superset of all other 64-bit configs.


-Olof
