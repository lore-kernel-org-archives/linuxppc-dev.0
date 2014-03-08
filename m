Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7F0C32C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Mar 2014 03:38:17 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 8 Mar 2014 09:38:15 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id C1AD61FF001A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Mar 2014 09:38:13 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s28GcDxx11272608
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Mar 2014 17:38:13 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s28GcD35026976
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Mar 2014 09:38:13 -0700
Date: Sun, 9 Mar 2014 00:37:56 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] eeh_pseries: Missing break?
Message-ID: <20140308163756.GA3766@shangw.(null)>
References: <1394238692.16156.115.camel@joe-AO722>
 <20140308161647.GA24296@shangw.(null)>
 <1394296003.6972.26.camel@joe-AO722>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394296003.6972.26.camel@joe-AO722>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 08, 2014 at 08:26:43AM -0800, Joe Perches wrote:
>On Sun, 2014-03-09 at 00:16 +0800, Gavin Shan wrote:
>> On Fri, Mar 07, 2014 at 04:31:32PM -0800, Joe Perches wrote:

.../...

>English usages of "double negatives" are different
>than other languages.  "it wasn't unintentional"
>means the same thing as "it was intentional".
>

Sorry, typo :)

>> Could you have better commit log
>> and subject, then repost it?
>> 

.../...

>From my perspective, you should write up a commit
>message of your own choice (I wouldn't use "we",
>but the rest seems OK) and add a Reported-by:
>
>All I did was notice it and bring it to your
>attention.
>

Ok. I will post it. Thanks!

Thanks,
Gavin


>> >---
>> >diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> >index 8a8f047..83da53f 100644
>> >--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>> >+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> >@@ -460,14 +460,15 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *state)
>> > 		case 5:
>> > 			if (rets[2]) {
>> > 				if (state) *state = rets[2];
>> > 				result = EEH_STATE_UNAVAILABLE;
>> > 			} else {
>> > 				result = EEH_STATE_NOT_SUPPORT;
>> > 			}
>> >+			break;
>> > 		default:
>> > 			result = EEH_STATE_NOT_SUPPORT;
>> > 		}
>> > 	} else {
>> > 		result = EEH_STATE_NOT_SUPPORT;
>> > 	}
>> >
>> 
>> Thanks,
>> Gavin
>> 
>
>
>
