Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB9152C023F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 15:41:13 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Jul 2012 11:11:08 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6N5f5Kj28114994
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 11:11:05 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6NBAc39030770
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 16:40:38 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V3 02/11] arch/powerpc: Simplify hpte_decode
In-Reply-To: <20120722232635.GB17790@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120722232635.GB17790@bloggs.ozlabs.ibm.com>
Date: Mon, 23 Jul 2012 11:11:04 +0530
Message-ID: <87liibhw5r.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Mon, Jul 09, 2012 at 06:43:32PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> This patch simplify hpte_decode for easy switching of virtual address to
>> virtual page number in the later patch
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> I'm not convinced your version is simpler than what was there before.
> It's certainly longer now.  But it does seem to do the same calculation
> as before, so:

This actually make patch 3 "arch/powerpc: Convert virtual address to vpn"
simpler. The hpte_decode hunk is a one line change after this 

>
> Reviewed-by: Paul Mackerras <paulus@samba.org>

-aneesh
