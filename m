Return-Path: <bharata@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmdtL5ntNzDqk0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 00:41:14 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1LDdBm5072448
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 08:41:11 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g96rfr0tv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 08:41:11 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Wed, 21 Feb 2018 13:41:10 -0000
Date: Wed, 21 Feb 2018 19:11:02 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v0 0/2] ibm,dynamic-memory-v2 fix
Reply-To: bharata@linux.vnet.ibm.com
References: <1519209387-29767-1-git-send-email-bharata@linux.vnet.ibm.com>
 <CAKTCnzm8TJBWG2VG9Bts2zQF01Tsya72bJJSTRimE32XuFC-YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKTCnzm8TJBWG2VG9Bts2zQF01Tsya72bJJSTRimE32XuFC-YA@mail.gmail.com>
Message-Id: <20180221134102.GB30038@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 21, 2018 at 11:27:20PM +1100, Balbir Singh wrote:
> On Wed, Feb 21, 2018 at 9:36 PM, Bharata B Rao
> <bharata@linux.vnet.ibm.com> wrote:
> > Patch 1 fixes a bug that results in unexpected flag bit in
> > ibm,dynamic-memory-v2 DT property and wrong number of entries
> > getting created in the same property during hotplug.
> >
> 
> Could you please elaborate on what this means?

Described in 1/2 patch.

> Is there a test case -
> how do we reproduce this?

Hotplug some memory and check the entries in ibm,dynamic-memory-v2 and also
check the flags there, you will see DRMEM_LMB_RESERVED set, which
shouldn't be set.

You would need QEMU which supports ibm,dynamic-memory-v2. I have posted
the initial patches for that at:

http://lists.gnu.org/archive/html/qemu-ppc/2018-02/msg00236.html

Regards,
Bharata.
