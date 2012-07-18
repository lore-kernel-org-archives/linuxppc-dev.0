Return-Path: <ogerlitz@mellanox.com>
Received: from eu1sys200aog105.obsmtp.com (eu1sys200aog105.obsmtp.com
 [207.126.144.119]) by ozlabs.org (Postfix) with SMTP id AA8A62C0327
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2012 01:05:54 +1000 (EST)
Message-ID: <5006CF3E.8090903@mellanox.com>
Date: Wed, 18 Jul 2012 17:59:10 +0300
From: Or Gerlitz <ogerlitz@mellanox.com>
MIME-Version: 1.0
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>, "Yevgeny
 Petrilin" <yevgenyp@mellanox.com>
Subject: Re: [PATCH] mlx4_en: map entire pages to increase throughput
References: <1342458113-10384-1-git-send-email-cascardo@linux.vnet.ibm.com>
 <50044F1D.6000703@hp.com> <20120716190611.GA1023@oc1711230544.ibm.com>
 <50046EB1.5040909@hp.com>
 <CAJZOPZL3F+xdHSFfhg7v9A6DDjT6CPK=kgwyzcE6c0pGYFyupg@mail.gmail.com>
 <20120716205708.GB16137@oc1711230544.ibm.com>
In-Reply-To: <20120716205708.GB16137@oc1711230544.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Or Gerlitz <or.gerlitz@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Rick Jones <rick.jones2@hp.com>, "amirv@mellanox.com" <amirv@mellanox.com>,
 "leitao@linux.vnet.ibm.com" <leitao@linux.vnet.ibm.com>,
 "klebers@linux.vnet.ibm.com" <klebers@linux.vnet.ibm.com>,
 "anton@samba.org" <anton@samba.org>,
 "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>,
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

On 7/16/2012 11:57 PM, Thadeu Lima de Souza Cascardo wrote:
> On Mon, Jul 16, 2012 at 11:43:33PM +0300, Or Gerlitz wrote:
>>
>>
>> TCP_STREAM from this setup before the patch would be good to know as well
>>
>
> Does the stream test that I did with uperf using messages of 64000 bytes fit?

netperf/TCP_STREAM is very common and it would help to better compare 
the numbers
you get on your systems before/after the patch which runs done here. As 
for review for
the patch itself and the related discussion, Yevgeny Petrilin should be 
looking on your
patch, he'll be in by early next week.

Or.
