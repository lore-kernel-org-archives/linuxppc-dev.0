Return-Path: <knight@princeton.edu>
Received: from skuld.princeton.edu (skuld.Princeton.EDU [128.112.173.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D32062C009E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 08:16:34 +1100 (EST)
Received: from [0.0.0.0] (hel.Princeton.EDU [128.112.173.229])
 (authenticated bits=0)
 by skuld.princeton.edu (8.14.7/8.14.7) with ESMTP id r9PLGUsG009191
 (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2013 17:16:31 -0400
Message-ID: <526ADFAB.7080401@princeton.edu>
Date: Fri, 25 Oct 2013 17:16:27 -0400
From: Robert Knight <knight@princeton.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: IBM OpenPower 720 ipr driver woes
References: <51A61B82.5050508@princeton.edu>
 <51A644C2.5090300@linux.vnet.ibm.com> <51AD088C.8040803@princeton.edu>
 <20130604000130.GA25055@thor.bakeyournoodle.com>
 <51AD45A4.9080702@princeton.edu>
 <20130604031651.GA3373@thor.bakeyournoodle.com>
 <20130604035223.GA27964@shangw.(null)> <51AFAA2C.5060304@princeton.edu>
 <51B07336.7040609@linux.vnet.ibm.com> <51B08311.3080406@princeton.edu>
 <20130607002459.GA5512@shangw.(null)> <525FFACB.8010303@princeton.edu>
In-Reply-To: <525FFACB.8010303@princeton.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/17/2013 10:57 AM, Robert Knight wrote:
> Well, it's four months later and I'm trying to get Fedora 20 Alpha to 
> install on that same machine.  It appears to still have the same 
> problem.  Did that patch ever make it into the mainline?
>
> Strangely, the kernel from the installer (using DVD image) does NOT 
> have the problem, only the installed system.
Just to follow up on this.

The problem does not appear to be the kernel.  Installing on one disk 
succeeds in producing a bootable system every time.  Installing on all 
four disks (two 73 GB disks and two 146 GB disks) never succeeds.

Although there are a storm of ipr driver messages as before, that is 
likely not the problem.

I'm going to continue on #fedora-ppc and the corresponding mailing list.
