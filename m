Message-Id: <19990318044316.Postino-005954@smtp01.highway.ne.jp>
Date: Thu, 18 Mar 1999 04:43:16 +0900
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: egcs-1.1.2-RPM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Andreas Tobler <a.tobler@schweiz.ch>
To: linux ppc <linuxppc-user@lists.linuxppc.org>, "linuxppc-dev@lists.linuxppc.org
" <linuxppc-dev@lists.linuxppc.org>
Subject: egcs-1.1.2-RPM
Date: Wed, 17 Mar 1999 10:01:36 +0100

> 
> Hi,
> 
> maybe a dump question, is anybody working on a RPM for
> egcs-1.1.2-glibc1.99? And or egcs-1.1.2-glibc-2.1.
> If not can I try it by adapting a RPM from a earlier release? I never
> made a RPM from scratch, I only modified them.
> 
> Yesterday, I built egcs-1.1.2 under R4.1. It worked out of the box?! Now
> I have to compare the test results. I can't believe it, before I had so
> many troubles building an egcs directly from egcs.cygnus.com.
> 
> A last question, what are the minimal requirements to build egcs under
> pre-R5. Means glibc etc.

I have egcs-1.1.2 for glibc-2.1.
Here is ftp://ppc.linux.or.jp/pub/users/fukui/Drugstore-in-Rawhide/new-egcs-glibc/
RPMS

If you want to use egcs on glibc-1.99 ,You patch  it tranpoline.patch.
Mr. Gary have  that patch.

I use  glibc-2.1 on PM-6100.

Thanks.

Kaoru Fukui
fukui@ppc.linux.or.jp




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
