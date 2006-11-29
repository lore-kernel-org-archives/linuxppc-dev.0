Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D11C067BB6
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Nov 2006 06:32:32 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kATJWSrh009327
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Nov 2006 14:32:28 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kATJWSFI535530
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Nov 2006 12:32:28 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kATJWSTJ029347
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Nov 2006 12:32:28 -0700
Date: Wed, 29 Nov 2006 13:32:27 -0600
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ppc64_defconfig to use AUTOFS_V4 not V3
Message-ID: <20061129193227.GO10879@austin.ibm.com>
References: <20061129180522.GM10879@austin.ibm.com>
	<20061129124511.3be6b9a8@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061129124511.3be6b9a8@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
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

On Wed, Nov 29, 2006 at 12:45:11PM -0600, Olof Johansson wrote:
> On Wed, 29 Nov 2006 12:05:22 -0600 linas@austin.ibm.com (Linas Vepstas) wrote:
> 
> > Please apply. Although I have a general question: who is served
> > by the ppc64_defconfig these days? Any reason why its not more 
> > like powerpc_defcofig?  "make defconfig" uses uname -m to pick up
> > the defconfig, and my cell, rhel5 and sles10 boxes report ppc64 
> > not pseries for uname -m.  
> 
> I like using it to build a kernel that runs on as much as possible with
> a single image, but I don't think all platforms have been added there
> (yet). Sort of like a superset of all other 64-bit configs.

Ahh, well, in that case, I propsoe turning on the following as well.

CONFIG_USB_MON=y
CONFIG_FUSE_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_XMON_DEFAULT=y

and a few device drivers:
CONFIG_IXGB_NAPI=y
CONFIG_S2IO=m
CONFIG_S2IO_NAPI=y

I had mistook ppc64 as being subset-ish not superset-ish.

--linas
