Message-ID: <39DB7292.3795DC65@erols.com>
Date: Wed, 04 Oct 2000 14:10:27 -0400
From: Erik Winkler <ewinkler@erols.com>
Reply-To: ewinkler@erols.com
MIME-Version: 1.0
To: Kevin Buettner <kev@primenet.com>
CC: mnorton@cisco.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Purify or Comparable???
References: <39DAFC02.52938515@cisco.com> <1001004171407.ZM31953@saguaro.lan>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've used purify in a SunOS environment and it worked great.  Combined with
Pure Coverage I was able to test all my code for memory leaks.  I'm not
sure if it's available for LinuxPPC, but maybe for Linux i386.

Erik

Kevin Buettner wrote:

> On Oct 4,  5:44am, Michael Norton wrote:
>
> > What software tool is recommended for examining memory leaks in code?
> > Does a close cousin of Purify exist for LinuxPPC/ What do you coders
> > recommend?
>
> I've never used Purify, so I can't offer a comparison, but...
>
> I've found that dmalloc works quite well for debugging memory
> allocation related problems.  See http://dmalloc.com/.
>
> Kevin
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
