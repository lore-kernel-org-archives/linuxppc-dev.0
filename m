Return-Path: <brking@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 164021A0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 06:50:12 +1000 (AEST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Tue, 22 Sep 2015 14:50:10 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 43B501FF0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 14:41:17 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t8MKo8bm8585504
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 13:50:08 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8MKo6Kd029897
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 14:50:07 -0600
Subject: Re: [PATCH v2 18/30] cxlflash: Remove dual port online dependency
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1442439038-49894-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <56007E7E.3090804@linux.vnet.ibm.com>
 <7DACBD20-4923-48A3-A773-829A938E34C9@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Ian Munsie <imunsie@au1.ibm.com>, Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
From: Brian King <brking@linux.vnet.ibm.com>
Message-ID: <5601BEFE.8060308@linux.vnet.ibm.com>
Date: Tue, 22 Sep 2015 15:50:06 -0500
MIME-Version: 1.0
In-Reply-To: <7DACBD20-4923-48A3-A773-829A938E34C9@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/22/2015 03:44 PM, Matthew R. Ochs wrote:
>> On Sep 21, 2015, at 5:02 PM, Brian King <brking@linux.vnet.ibm.com> wrote:
>> On 09/16/2015 04:30 PM, Matthew R. Ochs wrote:
>>> At present, both ports must be online for the device to
>>> configure properly. Remove this dependency and the unnecessary
>>> internal LUN override logic as well. Additionally, as a refactoring
>>> measure, change the return code variable name to match that used
>>> throughout the driver.
>>
>> Doesn't this also change the behavior to no longer fail init_afu even
>> if BOTH ports fail to go offline in the reconfig case. Is that OK?
> 
> Correct, there is a change in behavior but it is not an issue.
> 

ok.

Reviewed-by: Brian King <brking@linux.vnet.ibm.com>

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
