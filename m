Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6318E2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 18:48:03 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 15 May 2013 02:48:00 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5971719D8036
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 02:47:37 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4F8lhSL112864
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 02:47:43 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4F8lhfq012698
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 02:47:43 -0600
Date: Wed, 15 May 2013 16:47:40 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 00/22] powerpc/eeh: Enhance converting EEH dev
Message-ID: <20130515084740.GA22813@shangw.(null)>
References: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1368590264.31689.69.camel@pasglop>
 <20130515053049.GA28780@shangw.(null)>
 <1368597537.31689.70.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368597537.31689.70.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 15, 2013 at 03:58:57PM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2013-05-15 at 13:30 +0800, Gavin Shan wrote:
>> >There is an error injection framework we can use nowadays, or maybe you can
>> >put this in tools/powerpc ?
>> >
>> 
>> Ben, we don't have error injection framework yet. I have one source file "eeh-debug.c"
>> which exports P7IOC registers through procfs. In order to force EEH errors (frozen PE
>> or fenced PHB), we need change the specific bits of corresponding HW registers through
>> the procfs entries (e.g. /proc/IODA/PHBx/REG).
>
>I mean Linux has an error injection framework :-) We could hook up something into it.
>

Ok. Ben. Could you please point me the source code of the error injection framework? :-)
I think you're not talking about userland utility "errinject".

Thanks,
Gavin
