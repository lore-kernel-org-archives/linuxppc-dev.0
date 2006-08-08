Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9528A67B53
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Aug 2006 17:46:32 +1000 (EST)
Message-ID: <44D84145.7020408@sipsolutions.net>
Date: Tue, 08 Aug 2006 09:46:13 +0200
From: Johannes Berg <johannes@sipsolutions.net>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] update {g5,iseries,pseries}_defconfigs
References: <1154718328.5748.13.camel@farscape.rchland.ibm.com>
	<17624.10083.56514.758904@cargo.ozlabs.ibm.com>
In-Reply-To: <17624.10083.56514.758904@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
>> +# CONFIG_SND_AOA is not set
>> +# CONFIG_SND_AOA_SOUNDBUS is not set
>>     
>
> We want these on for G5s.
>   

newer PowerBooks/iBooks as well, and we'll want the new options these 
open up, i.e. all the codecs.

Apologies for not updating the defconfigs myself, I just didn't think of 
it :/

johannes
