Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BEE1C2C00AA
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2012 18:03:52 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 20 Dec 2012 00:03:50 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 295E63E40042
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2012 00:03:41 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBK73hoo212888
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2012 00:03:44 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBK73f0B007905
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2012 00:03:43 -0700
Date: Wed, 19 Dec 2012 23:03:29 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 3/5] perf/POWER7: Make generic event translations
 available in sysfs
Message-ID: <20121220070323.GA16711@us.ibm.com>
References: <20121219072646.GA30580@us.ibm.com>
 <20121219072848.GB30790@us.ibm.com>
 <20121220053600.GC28007@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121220053600.GC28007@kroah.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, robert.richter@amd.com,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg KH [greg@kroah.com] wrote:
| On Tue, Dec 18, 2012 at 11:28:49PM -0800, Sukadev Bhattiprolu wrote:
| > 
| > [PATCH 3/5] perf/POWER7: Make generic event translations available in sysfs
| 
| As you are adding new sysfs files, you must also add new
| Documentation/ABI entries at the same time.  Please also do this for the
| other patches in this series that add new sysfs files.

Ok. Will wait for any other review comments on this patchset and repost with
the ABI info.

Sukadev
