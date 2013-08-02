Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 151382C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 05:05:08 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Sat, 3 Aug 2013 04:54:36 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A60F42CE804C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 05:04:58 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r72InEbr9109820
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 3 Aug 2013 04:49:14 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r72J4vY8006767
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 3 Aug 2013 05:04:58 +1000
Message-ID: <51FC02D6.6050202@linux.vnet.ibm.com>
Date: Fri, 02 Aug 2013 14:04:54 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/8] register bootmem pages for powerpc when sparse vmemmap
 is not defined
References: <51F01E06.6090800@linux.vnet.ibm.com>
 <51F01E5F.80307@linux.vnet.ibm.com> <20130802022703.GA1680@concordia>
In-Reply-To: <20130802022703.GA1680@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mm <linux-mm@kvack.org>, isimatu.yasuaki@jp.fujitsu.com,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/01/2013 09:27 PM, Michael Ellerman wrote:
> On Wed, Jul 24, 2013 at 01:35:11PM -0500, Nathan Fontenot wrote:
>> Previous commit 46723bfa540... introduced a new config option
>> HAVE_BOOTMEM_INFO_NODE that ended up breaking memory hot-remove for powerpc
>> when sparse vmemmap is not defined.
> 
> So that's a bug fix that should go into 3.10 stable?
> 

Yes, I believe this one as well as patch 2/8 should go into 3.10 stable.

I'll re-send with linux stable added.

-Nathan
