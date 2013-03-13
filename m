Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7B1F52C007B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 20:49:14 +1100 (EST)
Message-ID: <1363168141.8993.34.camel@pasglop>
Subject: Re: [PATCH -V3 2/3] powerpc: Update kernel VSID range
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 13 Mar 2013 20:49:01 +1100
In-Reply-To: <87a9q7d5gt.fsf@linux.vnet.ibm.com>
References: <1363090131-14545-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1363090131-14545-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130313034254.GC21125@iris.ozlabs.ibm.com>
 <87a9q7d5gt.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-03-13 at 14:47 +0530, Aneesh Kumar K.V wrote:
> I update the commit message but missed updating this.  
> 
> Ben,
> 
> Let me know if you want me to send V4 to take care of these review
> feedbacks.

Yes please, I'll fix up my local merge branch with your new patch
tomorrow (I had applied but not pushed out yet) and will push out the
result to Linus.

Cheers,
Ben.
