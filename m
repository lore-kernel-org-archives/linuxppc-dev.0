Message-Id: <200005240959.KAA18934@copper.dcs.qmw.ac.uk>
To: Joseph Garcia <jpgarcia@execpc.com>
cc: Stephan Leemburg <stephan@jvc.nl>,
        Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Sergio Brandano <sb@dcs.qmw.ac.uk>, linuxppc-dev@lists.linuxppc.org,
        debian-powerpc@lists.debian.org, sb@dcs.qmw.ac.uk
Subject: Re: PMUD vs APM 
In-Reply-To: Message from Joseph Garcia <jpgarcia@execpc.com>
   of "Wed, 24 May 2000 02:31:23 EST." <392B854B.F9AC566E@execpc.com>
References: <B5514D3F.E6B3%stephan@jvc.nl>  <392B854B.F9AC566E@execpc.com> 
Date: Wed, 24 May 2000 11:00:43 +0000
From: Sergio Brandano <sb@dcs.qmw.ac.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 Hi Joseph,

> I also found this kind of annoying.  And as far as I can tell, APM
> doesn't show everything.  This is why I wrote a plugin for GKrellM
> that, using PMUD, displays battery status in a window.

 You are right. I have dropped my interest on apmd since I discovered
 gkrellm-pmud. And I have been advertising it on (my) PB page too, as
 you probably know.

> Its almost as good as Batmon, but smaller.

 I find gkrellm way better than Batmon. Why do you say ``almost''?
 Why is Batmon still better than gkrellm-pmud? (it results to me that
 the underlying code was written by Paul...)

 It would be a good thing, however, to have a unified monitoring
 system despite the hardware. I mean Intels are based on apm, PPCs are
 based on pmu, but do applications need to know it?

 Sergio

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
