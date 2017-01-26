Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3v8V4001QJzDq78
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 04:57:03 +1100 (AEDT)
Date: Thu, 26 Jan 2017 12:56:58 -0500 (EST)
Message-Id: <20170126.125658.909712109140919732.davem@davemloft.net>
To: tlfalcon@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, wvoigt@us.ibm.com, jallen@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com
Subject: Re: [PATCH net 2/5] ibmvnic: Fix MTU settings
From: David Miller <davem@davemloft.net>
In-Reply-To: <783c7683-1cc2-6128-e19c-fd2c3c16cf4b@linux.vnet.ibm.com>
References: <1485378143-5084-2-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <20170125.230504.215468934911959234.davem@davemloft.net>
 <783c7683-1cc2-6128-e19c-fd2c3c16cf4b@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Thu, 26 Jan 2017 10:44:31 -0600

> On 01/25/2017 10:05 PM, David Miller wrote:
>> From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
>> Date: Wed, 25 Jan 2017 15:02:20 -0600
>>
>>> In the current driver, the MTU is set to the maximum value
>>> capable for the backing device. This patch sets the MTU to the
>>> default value for a Linux net device.
>> Why are you doing this?
>>
>> What happens to users who depend upon the current behavior.
>>
>> They will break, and that isn't acceptable.
>>
> The current behavior was already broken.  We were seeing firmware errors when sending jumbo sized packets .  We plan to add proper support for jumbo sized packets as soon as possible.  

Need to be explained, with a full detailed history of how things got this way,
in your commit message.

 
