Message-Id: <36C15AD3.EB073AAC@pop.agri.ch>
Date: Wed, 10 Feb 1999 11:09:25 +0100
From: Andreas <toa@pop.agri.ch>
Mime-Version: 1.0
To: Gary Thomas <gdt@linuxppc.org>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: building egcs under LinuxPPC pre-R5
References: <XFMail.990210094035.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gary Thomas wrote:
> 
> The latest snapshots are very unstable on Linux/PPC.  We are working on
> this now, but I'd stay away from them until further notice.
> 

Thanks, good to know. I tried lots of hours to get them compile and build on a
'slow' 7200.

> On 10-Feb-99 Andreas Tobler wrote:
> > Hello,
> >
> > since the beginning of February I try to build egcs snapshot 19990131
> > and now 19990208. The succcess is small. I got the 19990131 snapshot to
> > build and install, but when I compile c++ code with some include
> > restrictions it seems that it overrides it which causes an error. The
> > egcs I used before and now again, was 2.91.60 I think, for LinuxPPC
> > folks egcs-1.1.1.1c. With this compiler I haven't had this error.
> > My question, is there something specific when building an egcs on
> > LinuxPPC that I have to take care of? It's not necessary for me to take
> > a snapshot, but I need to build an egcs & libstdc++ with the option
> > -fno-vtable-thunks.
> 
> The version of EGCS-1.1.1c that I uploaded should have been compiled this
> way.  What makes you think it was not?
> 
I try to build JX under pre-R5. As far as now I got it to build, but when I
play around with the menu options I get a core dump. 
As pointed out by John Lindal, one of the JX guys, this situation happens when
the vtable-thunks are enabled.
So I decided to try it by myself.
(I have to re-verify my system what libstdc++ and so on, but my rpms are from
4.1.99 as I remember)

Thanks
Andreas
-- 
------------------
| Andreas Tobler								
| CH-8004 Zuerich	
| E-mail: toa@pop.agri.ch		
------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
