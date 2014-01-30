Return-Path: <greg@kroah.com>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8A0372C008F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 09:36:22 +1100 (EST)
Date: Thu, 30 Jan 2014 14:37:35 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix compile error of pgtable-ppc64.h
Message-ID: <20140130223735.GC4046@kroah.com>
References: <1390911762-5659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390911762-5659-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140129184544.GA23204@kroah.com>
 <1391036256.8524.81.camel@pasglop>
 <20140130123457.GA6571@kroah.com>
 <8761p15pzn.fsf@linux.vnet.ibm.com>
 <20140130175514.GA29370@kroah.com>
 <1391115541.29634.15.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391115541.29634.15.camel@pasglop>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 31, 2014 at 07:59:01AM +1100, Benjamin Herrenschmidt wrote:
> If that's an issue for you, just drop the 3.13 variant of the patch and
> we'll send it again with the build fix as soon as Linus has pulled the
> latter.

I have done that.

thanks,

greg k-h
