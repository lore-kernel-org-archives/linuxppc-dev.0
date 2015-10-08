Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 054861A0023
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 15:16:29 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D8F2A1402A8
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 15:16:28 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 8 Oct 2015 14:16:27 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A84652BB0059
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 15:16:24 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t984GB2V42336280
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 15:16:20 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t984FpOn020788
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 15:15:52 +1100
Message-ID: <5615EDF9.2050704@au1.ibm.com>
Date: Thu, 08 Oct 2015 15:15:53 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 5/8] powerpc/pseries: Cleanup on pseries_eeh_get_state()
References: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1444276739-20372-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1444276739-20372-6-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/15 14:58, Gavin Shan wrote:
> This cleans up pseries_eeh_get_state(), no functional changes:
>
>     * Return EEH_STATE_NOT_SUPPORT early when the 2nd RTAS output
>       argument is zero to avoid nested if statements.
>     * Skip clearing bits in the PE state represented by variable
>       "result" to simplify the code.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Much easier to follow!

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
