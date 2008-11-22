Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 273EEDDDF0
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 11:56:49 +1100 (EST)
Date: Fri, 21 Nov 2008 18:49:56 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: Nodes with no memory
Message-ID: <20081122004956.GT6830@localdomain>
References: <1227311441.11607.57.camel@nimitz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1227311441.11607.57.camel@nimitz>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, mjw <mjw@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dave Hansen wrote:
> I was handed off a bug report about a blade not booting with a, um
> "newer" kernel.

If you're unable to provide basic information such as the kernel
version then perhaps this isn't the best forum for discussing this.  :)


> I'm thinking that we need to at least fix careful_allocation() to oops
> and not return NULL, or check to make sure all it callers check its
> return code.

Well, careful_allocation() in current mainline tries pretty hard to
panic if it can't satisfy the request.  Why isn't that happening?
