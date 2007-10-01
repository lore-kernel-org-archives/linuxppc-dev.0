Return-Path: <bwarren@qstreams.com>
Received: from smtp100.biz.mail.re2.yahoo.com (smtp100.biz.mail.re2.yahoo.com
	[206.190.52.46]) by ozlabs.org (Postfix) with SMTP id 8B135DDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Oct 2007 05:49:25 +1000 (EST)
Message-ID: <47014F42.1010106@qstreams.com>
Date: Mon, 01 Oct 2007 15:49:22 -0400
From: Ben Warren <bwarren@qstreams.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH] Add platform support for the MPC837x RDB board
References: <11909173512321-git-send-email-ljd015@freescale.com>	<20070927191036.GD7838@mag.az.mvista.com>	<C908B0B881A6B949985D6BAA0D9469B402CD36A7@az33exm20.fsl.freescale.net>	<20070927195351.GE7838@mag.az.mvista.com>	<20070927150312.4eea96fd@weaponx.rchland.ibm.com>	<20070927212830.GA9610@lixom.net>
	<20071001191937.GA5785@mag.az.mvista.com>
In-Reply-To: <20071001191937.GA5785@mag.az.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: D'Abbraccio Joe-ljd015 <Joe.D'abbraccio@freescale.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mark A. Greer wrote:
> On Thu, Sep 27, 2007 at 04:28:30PM -0500, Olof Johansson wrote:
>   
>> On Thu, Sep 27, 2007 at 03:03:12PM -0500, Josh Boyer wrote:
>>     
>>> On Thu, 27 Sep 2007 12:53:51 -0700
>>> "Mark A. Greer" <mgreer@mvista.com> wrote:
>>>
>>>       
>>>> On Thu, Sep 27, 2007 at 12:41:57PM -0700, D'Abbraccio Joe-ljd015 wrote:
>>>>         
>>>>> Thanks for the advice, but I was just basing the list to post to on the
>>>>> MAINTAINERS file which states that this is the one for Embedded PPC83XX.
>>>>> If you still think that I should post to linuxppc-dev, let me know.
>>>>>           
>>>> Yes, I think it would be better to repost to linuxppc-dev.
>>>>
>>>> Does anyone have an objection to changing all of the:
>>>>
>>>> 	"L:	linuxppc-embedded@ozlabs.org"
>>>>
>>>> in MAINTAINERS to:
>>>>
>>>> 	"L:	linuxppc-dev@ozlabs.org" ??
>>>>
>>>> Kumar, Josh, Vitaly, et. al.?
>>>>         
>>> I personally don't care either way.  I'm already subscribed to both
>>> lists.
>>>
>>> Makes sense to go to linuxppc-dev given the arch/powerpc migration.
>>>       
>> I thought the -embedded list was created in the first place to keep some
>> of the "noise" off of -dev (i.e. "I can't get interface <foo> to work on
>> my custom <embedded eval board>-lookalike board, HELP!"). If people still
>> care about keeping that on a separate list, then we shouldn't change it.
>>     
>
> Yes, IIRC, that was the reason but now with the merge and low volume on this
> list, it makes sense to me to just get rid of -embedded.
>
>   
Perhaps my perspective is unique, but I doubt it. I find it nice that 
this list is low volume and not filled with endless patches about CHRP 
and P series and open firmware syntax blah blah blah...

No offense intended to all the people who are doing wonderful work 
expanding the Linux universe, but for your average dude or dudette 
working on embedded boards that happen to have a PowerPC processor, this 
list is a pretty good forum.

regards,
Ben
