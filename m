Return-Path: <sebott@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 134221A08BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 20:54:31 +1100 (AEDT)
Received: from localhost
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sebott@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 09:54:28 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id D16F91B08070
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 09:54:41 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1G9sP0B15859782
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 09:54:25 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G9sOWh011325
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 02:54:25 -0700
Date: Tue, 16 Feb 2016 10:54:23 +0100 (CET)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
In-Reply-To: <20160215213526.GA9766@node.shutemov.name>
Message-ID: <alpine.LFD.2.20.1602161053410.1762@schleppi>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name> <56BE00E7.1010303@de.ibm.com>
 <20160212181640.4eabb85f@thinkpad>
 <20160212231510.GB15142@node.shutemov.name>
 <alpine.LFD.2.20.1602131238260.1910@schleppi>
 <20160215113159.GA28832@node.shutemov.name>
 <20160215193702.4a15ed5e@thinkpad> <20160215213526.GA9766@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, 15 Feb 2016, Kirill A. Shutemov wrote:
> Just to make sure: commit 122afea9626a is fine, commit 61f5d698cc97
> crashes. Correct?

Correct.
