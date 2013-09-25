Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 7E2C22C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 10:18:48 +1000 (EST)
Message-ID: <52422BE4.4020905@tabi.org>
Date: Tue, 24 Sep 2013 19:18:44 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2][v3] powerpc/fsl-booke: Add initial T104x_QDS board
 support
References: <1379581205-24424-1-git-send-email-prabhakar@freescale.com>	
 <CAOZdJXVBV0LvEwTua_eyTHXJdOcHZKQCjiTrYocqfcQY5hosUw@mail.gmail.com>	
 <071A08F2C6A57E4E94D980ECA553F874F9CF8D@039-SN1MPN1-005.039d.mgd.msft.net>	
 <523BBC15.8030607@tabi.org> <1380065132.24959.144.camel@snotra.buserror.net>
In-Reply-To: <1380065132.24959.144.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Jain Priyanka-B32167 <B32167@freescale.com>,
 Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Kushwaha Prabhakar-B32579 <B32579@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
>> >I think it should be okay to leave the DIU node.  I think the kernel
>> >will crash if you try to enable a DIU console (video= on the kernel
>> >command line), but I think it's okay to ignore that for the moment.

> Sounds like a bug in the DIU driver.  It should fail gracefully in the
> absence of platform support.

I agree.  And one day, I'll get a chance to look at the code to see if 
it's broken.
