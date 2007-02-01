Return-Path: <thisismevinay@yahoo.co.in>
Received: from web8409.mail.in.yahoo.com (web8409.mail.in.yahoo.com
	[202.43.219.157]) by ozlabs.org (Postfix) with SMTP id DE6CFDDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 15:14:58 +1100 (EST)
Date: Wed, 31 Jan 2007 20:14:56 -0800 (PST)
From: vinay hegde <thisismevinay@yahoo.co.in>
Subject: Re: Differentiate between two e500 core (in mult-core e500)
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <9B19C2EE-5476-4091-B4FF-76C197B3BB53@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <902386.32469.qm@web8409.mail.in.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar,

Thanks for the pointers. This POST will run from the
bootcode. 

I looked into the block diagram for MPC8572, and it
seems that apart from L1 caches other component are
shared (foe ex, L2, table look-up unit, gigE, SDRAM).
So, I was wondering whether we can do something like -
run _all_ the POST from core 1 and run only L1 cache
test from core 2. 

Actually I referred 'e500 core Family Ref Manual', but
could not get answer to my below question. 

Thanks,
Vinay.

--- Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Jan 31, 2007, at 2:02 AM, vinay hegde wrote:
> 
> > Hi,
> >
> > Actually, what I mean is, there are two
> independent L1
> > caches (one in first e500 core and other in second
> > e500 core) in mpc8572. Now, if I am running cache
> > test(POST) on mpc8572, I must somehow make sure
> that
> > it tests both the L1 caches. Generally, earlier
> there
> > used to be one e500 core, one L1 cache and hence
> cache
> > test does not need to query whether it is testing
> L1
> > of first core or L1 of second.
> >
> > So, how to make sure that I am testing L1 caches
> on
> > _both_ the e500 cores?
> 
> Ok, will it sounds like just want to run your tests
> on both cores.   
> It depends on how you are invoking your tests today.
>  Is it from  
> bootcode? or a Linux app or driver?
> 
> - k
> 
> >> On Jan 30, 2007, at 10:58 PM, vinay hegde wrote:
> >>
> >>> Hi,
> >>>
> >>> Sorry for the repeat mail on this, I forgot to
> ask
> >> the
> >>> question;-)
> >>>
> >>> If anybody knows how to differentiate one e500
> >> core
> >>> from another (in multi-core proc's), please post
> a
> >>> message.
> >>
> >> Do you mean some software ID to know which core
> you
> >> are running on?
> >>
> >> If so the PIR should be used for this purpose.
> >>
> >> - k
> >>
> >>> --- vinay hegde <thisismevinay@yahoo.co.in>
> wrote:
> >>>
> >>>> Hi,
> >>>>
> >>>> I have a need to write a POST sort of a test to
> >> test
> >>>> L1 data/inst cache residing on each of the e500
> >> v2
> >>>> multi-core seperately (for a network hardware).
> >> This
> >>>> is because multicore e500 has seperate L1
> caches
> >> and
> >>>> shared L2 cache.
> >>>>
> >>>> This is for mpc8572. I learnt from this list
> that
> >>>> mpc8572 isn't out yet, but thought that
> >>>> differentiating between e500 mult-cores has
> >> nothing
> >>>> to
> >>>> do with mpc8572.
> >>>>
> >>>> Please let me know if you have any inputs.
> >>>>
> >>>> Thanks,
> >>>> Vinay.
> >>>>
> >>>>
> >>>>
> >>>>
> >>>
> >>
> >
>
______________________________________________________________________
> >>
> >>> ______________
> >>>> Expecting? Get great news right away with email
> >>>> Auto-Check.
> >>>> Try the Yahoo! Mail Beta.
> >>>>
> >>>
> >>
> >
>
http://advision.webevents.yahoo.com/mailbeta/newmail_tools.html
> >>>>
> >>>> _______________________________________________
> >>>> Linuxppc-embedded mailing list
> >>>> Linuxppc-embedded@ozlabs.org
> >>>>
> >>>
> >>
> >
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >>>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>
> >
>
______________________________________________________________________
> >>
> >>> ______________
> >>> Don't get soaked.  Take a quick peak at the
> >> forecast
> >>> with the Yahoo! Search weather shortcut.
> >>>
> >>
> http://tools.search.yahoo.com/shortcuts/#loc_weather
> >>> _______________________________________________
> >>> Linuxppc-embedded mailing list
> >>> Linuxppc-embedded@ozlabs.org
> >>>
> >>
> >
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >>
> >>
> >
> >
> >
> >
> >
>
______________________________________________________________________
> 
> > ______________
> > 8:00? 8:25? 8:40? Find a flick in no time
> > with the Yahoo! Search movie showtime shortcut.
> > http://tools.search.yahoo.com/shortcuts/#news
> 
> 



 
____________________________________________________________________________________
Expecting? Get great news right away with email Auto-Check. 
Try the Yahoo! Mail Beta.
http://advision.webevents.yahoo.com/mailbeta/newmail_tools.html 
