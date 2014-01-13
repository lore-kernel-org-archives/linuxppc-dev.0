Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5B93A2C0081
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 00:38:02 +1100 (EST)
Message-ID: <1389620262.4672.130.camel@pasglop>
Subject: Re: [PATCH V4] powerpc: thp: Fix crash on mremap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 14 Jan 2014 00:37:42 +1100
In-Reply-To: <87wqi42p0f.fsf@linux.vnet.ibm.com>
References: <1389593064-32664-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1389598587.4672.121.camel@pasglop> <87wqi42p0f.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aarcange@redhat.com, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 kirill.shutemov@linux.intel.com, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-01-13 at 15:16 +0530, Aneesh Kumar K.V wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > On Mon, 2014-01-13 at 11:34 +0530, Aneesh Kumar K.V wrote:
> >> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> >> 
> >> This patch fix the below crash
> >
> > Andrea, can you ack the generic bit please ?
> >
> > Thanks !
> 
> Kirill A. Shutemov did ack an earlier version
> 
> http://article.gmane.org/gmane.linux.kernel.mm/111368

Doesn't help. If I'm going to send Linus a patch with a generic change
like that, I need an ack of that exact version of the change by a senior
mm person such as Andrea.

Cheers,
Ben.
