Message-Id: <199910211134.GAA16627@lists.linuxppc.org>
Date: Thu, 21 Oct 1999 07:32:26 -0400 (EDT)
From: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Reply-To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Subject: Re: SuSE Rage 128 Xserver Source and XFree 3.3.6
To: luther@dpt-info.u-strasbg.fr
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

>So is the Rqge 128 driver stuff already in 3.9.16 ?
>

According to the list of Xservers given on the XFree86 org page, it is NOT 
included.  They have completely restructured Xservers for that release.  Now 
they all start with the base Xserver while calls up various shared-libraries to 
handle driver specifics / acceleration, etc.

Given XFree86 policy of not releasing source, (according to their website they 
specifically request that people *not* join just to get access to pre-release 
source).  I hope SuSE simply just posts the source.  

This whole process simply makes no sense.  Why give development source only to a 
body that can not release it for others?  Not exactly using the strength of the 
free software movement?

I guess I shouldn't complain, Sun won't let me release the JDK source to others 
(just diffs).

Kevin

--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA   
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
