Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C3F7A2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 12:44:35 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 15 May 2013 20:44:32 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 1FF033E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 20:44:14 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4G2iTTk078718
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 20:44:29 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4G2iSl6030731
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 20:44:29 -0600
Date: Thu, 16 May 2013 10:44:25 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 00/22] powerpc/eeh: Enhance converting EEH dev
Message-ID: <20130516024425.GA29423@shangw.(null)>
References: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1368590264.31689.69.camel@pasglop>
 <20130515053049.GA28780@shangw.(null)>
 <1368597537.31689.70.camel@pasglop>
 <20130515084740.GA22813@shangw.(null)>
 <1368611324.3659.0.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368611324.3659.0.camel@pasglop>
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

On Wed, May 15, 2013 at 07:48:44PM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2013-05-15 at 16:47 +0800, Gavin Shan wrote:
>> 
>> Ok. Ben. Could you please point me the source code of the error
>> injection framework? :-)
>> I think you're not talking about userland utility "errinject".
>
>It's minimal, it's just the stuff in lib/fault-inject which provides
>a framework for exposing attributes for injecting errors along with the
>tool in tools/testing/fault-injection, at least that's my understanding.
>
>Or we can just add stuff under debugfs/powerpc, which is what I did
>for wsp.
>

Thanks, Ben. I will look into that (probably next week) and hook something
there :-)

Thanks,
Gavin
