Return-Path: <linasvepstas@gmail.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.242])
	by ozlabs.org (Postfix) with ESMTP id 584AEDDF1C
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 04:38:02 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so2855842hsz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 10:38:00 -0700 (PDT)
Message-ID: <3ae3aa420803121038y1bf57920m953bb44e9d51aa1d@mail.gmail.com>
Date: Wed, 12 Mar 2008 11:38:00 -0600
From: "Linas Vepstas" <linasvepstas@gmail.com>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH 3/8] pseries: phyp dump: use sysfs to release reserved mem
In-Reply-To: <18390.9137.626123.104628@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <47B90F55.2080606@austin.ibm.com>
	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
	<47C74A66.1060105@austin.ibm.com> <47C75189.4070801@austin.ibm.com>
	<18390.9137.626123.104628@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mahuja@us.ibm.com
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/03/2008, Paul Mackerras <paulus@samba.org> wrote:
>
>  > ------
>
> This line needs to be exactly 3 dashes, because otherwise the tools
>  include the diffstat into the commit message.  Putting 4 or more
>  dashes was an annoying habit Linas had, and it means I have to fix it
>  manually (usually after I have committed the patches, and then notice
>  that the commit message has the extra stuff in it, so I have to go
>  back and fix the separators, reset my tree and re-commit the patches.)

Sorry, I had no idea!  If I didn't have enough dashes, then quilt would
sometimes wipe out the comment at the top, so paranoia made me
add lots of dashes.

--linas
