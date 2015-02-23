Return-Path: <clg@fr.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D535E1A0A02
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 02:23:44 +1100 (AEDT)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 23 Feb 2015 15:23:41 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5F2C82190068
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 15:23:32 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1NFNcfd6357470
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 15:23:38 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1NFNcNn023872
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 08:23:38 -0700
Message-ID: <54EB45E1.7040805@fr.ibm.com>
Date: Mon, 23 Feb 2015 16:23:13 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Thomas Haschka <haschka@gmail.com>, stable@vger.kernel.org,
 benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1]: thermal driver therm_adt746.c
References: <CADAoK=UH4q9x-OMyOpqCmGpNwDo3vey41xajBw-PDdupmEHnAA@mail.gmail.com>
In-Reply-To: <CADAoK=UH4q9x-OMyOpqCmGpNwDo3vey41xajBw-PDdupmEHnAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/23/2015 12:58 PM, Thomas Haschka wrote:
> Hi everyone,
> 
> The current driver linux/drivers/macintosh/therm_adt746x.c does not take the HDD BUTTOMSIDE sensor into account. It actually should as the 12" Powerbooks and IBooks are build in a way that the airflow cools the harddrive and components around it. Actually there are air intake openings just beneath the Harddrive. If you experiance hot enviromental temperatures as I did in summer on certain occations, you will find out that in MacOSX the fan spins up while it doesn't in linux. As this probably causes harddrives, and maybe other components to fail early I think this should be regarded as a fix to a severe bug.
> 
> Hence, I created this patch for single fan 12" Albooks, Ibooks etc.

I would happy to give it a try on the "brand new" iBook G4 I just 
got this week-end but I would need you to reformat your patch. 

Could you please send it again to the mailing using : 

	git send-email --to linuxppc-dev@lists.ozlabs.org my.patch
 
You might want to run the script ./scripts/checkpatch.pl on the
patch file before sending.

Cheers,

C. 
