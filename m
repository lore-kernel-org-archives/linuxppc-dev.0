Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402Bwd5dxlzF1Sq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 02:15:11 +1100 (AEDT)
Date: Thu, 15 Mar 2018 11:15:04 -0400 (EDT)
Message-Id: <20180315.111504.399791580409893462.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: joakim.tjernlund@infinera.com, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 camelia.groza@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] DPAA Ethernet fixes
From: David Miller <davem@davemloft.net>
In-Reply-To: <AM5PR04MB3267BC402A80D9E772BC8903ECD00@AM5PR04MB3267.eurprd04.prod.outlook.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
 <1521052994.4790.148.camel@infinera.com>
 <AM5PR04MB3267BC402A80D9E772BC8903ECD00@AM5PR04MB3267.eurprd04.prod.outlook.com>
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

From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
Date: Thu, 15 Mar 2018 09:32:35 +0000

>> -----Original Message-----
>> From: Joakim Tjernlund [mailto:Joakim.Tjernlund@infinera.com]
>> Sent: Wednesday, March 14, 2018 8:43 PM
>> To: davem@davemloft.net; Madalin-cristian Bucur
>> <madalin.bucur@nxp.com>
>> 
>> On Wed, 2018-03-14 at 08:37 -0500, Madalin Bucur wrote:
>> > Hi,
>> >
>> > This patch set is addressing several issues in the DPAA Ethernet
>> > driver suite:
>> >
>> >  - module unload crash caused by wrong reference to device being left
>> >    in the cleanup code after the DSA related changes
>> >  - scheduling wile atomic bug in QMan code revealed during dpaa_eth
>> >    module unload
>> >  - a couple of error counter fixes, a duplicated init in dpaa_eth.
>> 
>> hmm, some of these(all?) bugs are in stable too, CC: stable perhaps?
> 
> Hi Jocke,
> 
> I did not check that, they should be added.

Networking patches are not queued to stable by CC:'ing stable.

Instead you just simply need to ask me explicitly for -stable submission
which I will do at the appropriate time after the fixes have been able
to cook in Linus's tree for a little while.

I've queued this series up for that purpose, thanks.
