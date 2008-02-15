Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 99585DDF80
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 09:34:33 +1100 (EST)
Date: Sat, 16 Feb 2008 09:32:06 +1100
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 3/8] pseries: phyp dump: use sysfs to release reserved mem
Message-ID: <20080215223206.GL6887@bakeyournoodle.com>
References: <47B13D2E.1070001@austin.ibm.com> <47B146BE.5010807@austin.ibm.com>
	<20080215010528.GI6887@bakeyournoodle.com>
	<47B53C7C.2060403@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <47B53C7C.2060403@austin.ibm.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 15, 2008 at 01:17:16AM -0600, Manish Ahuja wrote:
> Tony Breeds wrote:
> > Any reason this sysfs attribute can't be write only? The show method
> > doesn't seem needed.
> 
> yes, its used later in the code.

I see that now, thanks.  From my point of view it would make reviewing 
these patches easier if each patch was a correct and simple as possible. 
In this case it would have made the review easier if the sysfs attribute 
was write only now and then modified to add the read side when it's 
actually implemented.  The same goes for fixing typosi, cosmetic changes
and reference counting. 

Looking forward to a respin of this patch series.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
