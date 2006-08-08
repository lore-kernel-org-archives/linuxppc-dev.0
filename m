Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5859E67B5F
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 00:44:37 +1000 (EST)
Message-ID: <44D8A33D.6070000@sipsolutions.net>
Date: Tue, 08 Aug 2006 16:44:13 +0200
From: Johannes Berg <johannes@sipsolutions.net>
MIME-Version: 1.0
To: will_schmidt@vnet.ibm.com
Subject: Re: [PATCH] update {g5,iseries,pseries}_defconfigs
References: <1154718328.5748.13.camel@farscape.rchland.ibm.com>	<17624.10083.56514.758904@cargo.ozlabs.ibm.com>	<44D84145.7020408@sipsolutions.net>
	<1155048001.5454.27.camel@farscape.rchland.ibm.com>
In-Reply-To: <1155048001.5454.27.camel@farscape.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Will Schmidt wrote:
> For G5, I've enabled SND_AOA and friends as
> modules; this includes the FABRIC_LAYOUT, ONYX, TAS, TOONIE and
> SOUNDBUS* config options.  
>   
Great, thanks.

Another thing I didn't think about earlier: does Apple ship any G5s that 
are old enough to not have a layout_id in their device tree? I'm not 
aware of any. If not, you might want to disable CONFIG_SND_POWERMAC for g5.

johannes
