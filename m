Return-Path: <rick.jones2@hp.com>
Received: from g6t0186.atlanta.hp.com (g6t0186.atlanta.hp.com [15.193.32.63])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4CF2B2C010D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 05:52:19 +1000 (EST)
Message-ID: <50046EB1.5040909@hp.com>
Date: Mon, 16 Jul 2012 12:42:41 -0700
From: Rick Jones <rick.jones2@hp.com>
MIME-Version: 1.0
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Subject: Re: [PATCH] mlx4_en: map entire pages to increase throughput
References: <1342458113-10384-1-git-send-email-cascardo@linux.vnet.ibm.com>
 <50044F1D.6000703@hp.com> <20120716190611.GA1023@oc1711230544.ibm.com>
In-Reply-To: <20120716190611.GA1023@oc1711230544.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "leitao@linux.vnet.ibm.com" <leitao@linux.vnet.ibm.com>,
 "amirv@mellanox.com" <amirv@mellanox.com>,
 "yevgenyp@mellanox.co.il" <yevgenyp@mellanox.co.il>,
 "klebers@linux.vnet.ibm.com" <klebers@linux.vnet.ibm.com>,
 "anton@samba.org" <anton@samba.org>,
 "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>,
 "ogerlitz@mellanox.com" <ogerlitz@mellanox.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/16/2012 12:06 PM, Thadeu Lima de Souza Cascardo wrote:
> On Mon, Jul 16, 2012 at 10:27:57AM -0700, Rick Jones wrote:
>
>> What is the effect on packet-per-second performance?  (eg aggregate,
>> burst-mode netperf TCP_RR with TCP_NODELAY set or perhaps UDP_RR)
>>
> I used uperf with TCP_NODELAY and 16 threads sending from another
> machine 64000-sized writes for 60 seconds.
>
> I get 5898op/s (3.02Gb/s) without the patch against 18022ops/s
> (9.23Gb/s) with the patch.

I was thinking more along the lines of an additional comparison, 
explicitly using netperf TCP_RR or something like it, not just the 
packets per second from a bulk transfer test.

rick
