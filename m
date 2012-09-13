Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C40882C0080
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 04:00:57 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 13 Sep 2012 12:00:52 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 412F93E4008A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 12:00:40 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8DI0VfM144600
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 12:00:32 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8DI0UkF004652
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 12:00:30 -0600
Date: Thu, 13 Sep 2012 11:00:11 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] pseries: double NR_CPUS in defconfig
Message-ID: <20120913180011.GG9269@linux.vnet.ibm.com>
References: <20120912174706.GE9269@linux.vnet.ibm.com>
 <20120913223739.48f27d7fbacca32b013777fc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120913223739.48f27d7fbacca32b013777fc@canb.auug.org.au>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stephen,

On 13.09.2012 [22:37:39 +1000], Stephen Rothwell wrote:
> Hi,
> 
> On Wed, 12 Sep 2012 10:47:07 -0700 Nishanth Aravamudan <nacc@linux.vnet.ibm.com> wrote:
> >
> > Anticipating growth in coming years, we should ensure we are getting
> > a good lead on testing.
> 
> Most changes to pseries_defconfig are copied into ppc64_defconfig.
> Should this one be as well?

Ah, I didn't realize that was the case, sorry. Yes, it probably does
make sense to do this change. Should I just send a follow-on patch?

Thanks,
Nish
