Message-ID: <412B6A16.5000101@246tNt.com>
Date: Tue, 24 Aug 2004 18:17:26 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Andrey Volkov <avolkov@varma-el.com>,
	Gabor Janak <g.janak@unicontrol.de>
Subject: [RFC] MPC5200 dev (was Re: [RFC] Re: BestComm and fec)
References: <412A4B69.7000305@246tNt.com> <149461203.20040824120707@varma-el.com> <1093337686.3777.755.camel@imladris.demon.co.uk> <16210643353.20040824145207@varma-el.com>
In-Reply-To: <16210643353.20040824145207@varma-el.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Since It's clear that with more peoples working on it, there is a need of
synchro.

Here's what I'm proposing :

I'll a tree :
   bk://bkbits.246tNt.com/linux-mpc52xx-devel
       This tree would contain all the latest code to be tested by
others. Just send patch to the ml and cc me, I'll put them in this
tree. Once every one is happy with it (or part of it), I'll take
care of pushing it upstream.
	Note that since all current work with bestcomm is based on
non-GPL code, It won't be in until Dale send me the version he's
working on (based on latest code).


To avoid duplicate work, you can post here what you're doing, I'll try
to keep
http://www.246tNt.com/mpc52xx/state-devel.txt  up-to-date with who's doing what.

The point is to centralize the testing code and having a 'single' contact
to merge the work upstream to ease the work of upstream maintainers.


This tree is being setup right now, please allow a few hours ;)


Comments, suggestions are of course welcome.


	Sylvain




Andrey Volkov wrote:

>Hello David,
>
>Tuesday, August 24, 2004, 12:54:46 PM, you wrote:
>
>
>
>
>>On Tue, 2004-08-24 at 12:07 +0400, Andrey Volkov wrote:
>>
>>
>>>Terrible, may be its time to create special project for MPC5200 (if it
>>>doesn't exist in somewhere in I-net)? First intention - sourceforge.
>>>Comments/suggestions?
>>>
>>>
>
>
>
>>Don't start a new project. Just put your changes into the official 2.6
>>tree.
>>
>>
>
>
>
>>The goal of _all_ external trees should be to make themselves obsolete
>>by getting all changes to Linus as quickly as possible. Why shoot
>>yourself in the foot?
>>
>>
>
>Indeed, BUT:
> 1) IMHO mail list better approach for
>    along developer <-> maintainer/many tester
> scheme of development. Cvs/bk will be better for team work isn't it?
>
> 2) So somewhere must exist place for coordination of job, 'cause
> I see as minimum 5 person doing SAME work (terrible).
>
> 3) And I wish have common place for experiments and testing. AFAIK, stable
> kernel is not appropriate for it. (If I wrong - why exist -mm -ac
> etc branches? :)
>
>--
>Best regards,
> Andrey Volkov
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
