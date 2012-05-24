Return-Path: <jan.ceuleers@computer.org>
Received: from mailrelay007.isp.belgacom.be (mailrelay007.isp.belgacom.be
 [195.238.6.173]) by ozlabs.org (Postfix) with ESMTP id 7F52AB6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2012 04:07:54 +1000 (EST)
Message-ID: <4FBE77E1.4010103@computer.org>
Date: Thu, 24 May 2012 20:03:13 +0200
From: Jan Ceuleers <jan.ceuleers@computer.org>
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] gianfar:don't add FCB length to hard_header_len
References: <1337677248-27792-1-git-send-email-b06378@freescale.com>
 <20120522.151830.2018953337014839778.davem@davemloft.net>
 <4FBE4E02.1070306@computer.org> <1337876210.5070.4.camel@joe2Laptop>
In-Reply-To: <1337876210.5070.4.camel@joe2Laptop>
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, b06378@freescale.com, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/24/2012 06:16 PM, Joe Perches wrote:
> On Thu, 2012-05-24 at 17:04 +0200, Jan Ceuleers wrote:
>> On 05/22/2012 09:18 PM, David Miller wrote:
>>> Someone needs to go through this driver when net-next opens up
>>> and fix all of the indentation in this driver.
>>
>> May I give that a go?
> 
> I have scripts that automate most of this.
> I don't have the card though.
> 
> Maybe this is a starting point?
> It doesn't fix most 80 column warnings.

Thanks Joe.

I also don't have the card; the kinds of changes I was proposing to make
are code-neutral, whose correctness I was intending to prove by a binary
compare of the before-and-after .o.

Still happy to do that taking your contribution as a starting point.

Thanks, Jan
