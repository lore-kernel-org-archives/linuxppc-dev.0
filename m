Return-Path: <clg@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5B58D2C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 20:37:48 +1100 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 21 Mar 2014 09:37:44 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 78A681B08040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 09:37:32 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2L9bTNa56688718
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 09:37:29 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2L9bese009401
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 03:37:41 -0600
Message-ID: <532C0856.6090707@fr.ibm.com>
Date: Fri, 21 Mar 2014 10:37:26 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH 00/18] powerpc/boot: 64bit little endian wrapper
References: <1391788771-16405-1-git-send-email-clg@fr.ibm.com>
 <1395328213-19206-1-git-send-email-clg@fr.ibm.com>
 <1395335024.20123.2.camel@smoke> <532BFA38.9090904@fr.ibm.com>
In-Reply-To: <532BFA38.9090904@fr.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Geoff,
 
>> Do you have these in a git branch somewhere so I can merge and test
>> them?
> 
> No, sorry, I don't have a public git repo. Let me see how I can fix 
> that, it might be useful for future patchsets. 

Please try that :

	git pull git://github.com/legoater/linux.git zimage

Thanks,

C.
