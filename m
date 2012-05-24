Return-Path: <jan.ceuleers@computer.org>
Received: from mailrelay012.isp.belgacom.be (mailrelay012.isp.belgacom.be
 [195.238.6.179]) by ozlabs.org (Postfix) with ESMTP id 77E0EB6FCB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2012 01:07:57 +1000 (EST)
Message-ID: <4FBE4E02.1070306@computer.org>
Date: Thu, 24 May 2012 17:04:34 +0200
From: Jan Ceuleers <jan.ceuleers@computer.org>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] gianfar:don't add FCB length to hard_header_len
References: <1337677248-27792-1-git-send-email-b06378@freescale.com>
 <20120522.151830.2018953337014839778.davem@davemloft.net>
In-Reply-To: <20120522.151830.2018953337014839778.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, b06378@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/22/2012 09:18 PM, David Miller wrote:
> From: Jiajun Wu <b06378@freescale.com>
> Date: Tue, 22 May 2012 17:00:48 +0800
> 
>> FCB(Frame Control Block) isn't the part of netdev hard header.
>> Add FCB to hard_header_len will make GRO fail at MAC comparision stage.
>>
>> Signed-off-by: Jiajun Wu <b06378@freescale.com>
> 
> Applied, thanks.
> 
> Someone needs to go through this driver when net-next opens up
> and fix all of the indentation in this driver.

May I give that a go?
