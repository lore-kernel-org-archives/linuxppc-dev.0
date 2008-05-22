Return-Path: <sygao.research@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 9C935DE010
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 May 2008 09:47:48 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so72924anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 May 2008 16:47:47 -0700 (PDT)
In-Reply-To: <4835FC73.5080102@dlasys.net>
References: <4835FC73.5080102@dlasys.net>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B73A6511-C11B-43C3-A42E-53D8816CF608@gmail.com>
From: Shanyuan Gao <sygao.research@gmail.com>
Subject: Re: APU FPU in Virtex ppc405 
Date: Thu, 22 May 2008 19:47:39 -0400
To: dhlii@dlasys.net
Cc: John Bonesio <john.bonesio@xilinx.com>,
	Thomas Werne <thomas.a.werne@jpl.nasa.gov>,
	"A. Nolson" <alohanono@gmail.com>,
	Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	Shanyuan Gao <sygao.research@gmail.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Yes, it's working under Linux.  Just do as John, Steve, and Yoshio  
suggest.  That should work then.  My problem was that our own cross- 
tool was not working correctly.  But we will fix it in next couple of  
weeks.

I did very primitive changes and didn't have a patch.  In next few  
weeks we might want to go for powerpc tree then, so  I will try to do  
it all over again.



Shan


On May 22, 2008, at 7:06 PM, David H. Lynch Jr. wrote:

>    Were the issues associated with getting the Xilinx Floating  
> point APU
> working with Linux completely resolved ?
>     Is there a git tree or patch collection with the appropriate  
> patches
> etc ?
>
>
>
> -- 
> Dave Lynch 					  	    DLA Systems
> Software Development:  				         Embedded Linux
> 717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
> fax: 1.253.369.9244 			           Cell: 1.717.587.7774
> Over 25 years' experience in platforms, languages, and technologies  
> too numerous to list.
>
> "Any intelligent fool can make things bigger and more complex... It  
> takes a touch of genius - and a lot of courage to move in the  
> opposite direction."
> Albert Einstein
>
