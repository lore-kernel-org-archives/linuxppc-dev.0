Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mYvl5x2czF14x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 11:42:27 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4H1cxLP119483
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 21:42:25 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j0y5hab0b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 21:42:24 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 17 May 2018 02:42:23 +0100
Subject: Re: administrivia: mails containing HTML attachments
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20180516144829.2dbefb0b@canb.auug.org.au>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 17 May 2018 11:42:18 +1000
MIME-Version: 1.0
In-Reply-To: <20180516144829.2dbefb0b@canb.auug.org.au>
Message-Id: <79d78539-19b0-0647-e823-fe0ba8d1c839@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/05/18 14:48, Stephen Rothwell wrote:
> Hi all,
> 
> I have decided that any email sent to the linuxppc-dev mailing list
> that contains an HTML attachment (or is just an HTML email) will be
> rejected.  The vast majority of such mail are spam (and I have to spend
> time dropping them manually at the moment) and, I presume, anyone on
> this list is capable of sending no HTML email.
> 
> Feel free to discuss ;-)

As it turns out, there's some bugs in how Patchwork handles HTML emails 
that can screw up the resulting patch mboxes when retrieved from 
Patchwork. We're hoping to fix that in the next Patchwork release, but 
in the meantime this restriction should stop us running into any issues 
on this list.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
