To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet PHY chip discovery not working on 855T with 971/972 chips 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Jul 2003 12:34:35 PDT."
             <20030711193435.GC17433@ip68-0-152-218.tc.ph.cox.net>
Date: Fri, 11 Jul 2003 23:04:29 +0200
Message-Id: <20030711210434.D1566C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030711193435.GC17433@ip68-0-152-218.tc.ph.cox.net> you wrote:
>
> Are you modifying ppc8xx_pic.c ?  And yes, it does need generic updates.

No, not at the moment. But how can I understand the stuff in 2.5 if I
cannot even compile the code for any standard 8xx system? Any  effort
to add more code of similar quality is a waste of time.

> You don't have time to find a pointer to a discussion?  Then I can't say
> why nothing happened, but I'll wager a guess that Dan Malek didn't like
> it for some reason.

I can dig out the original messages when I sent you  the  patches,  I
can  try to find traces in the archives. It takes time, but what will
be the result? If nothing happened then, I don't expect  anything  to
happen now.

You are right, patches get rejected because somebody didn't  like  it
for  some  reason.  But  if  these  patches are addressing reoccuring
problems, and no other  (better)  solution  gets  implemented,  which
sense does it make to reject the stuff?

I'm sorry, but both you and me remember that we had discussions  like
this  before,  and obviously nothing has changed since. So the result
will be the same. We can stop that here.


> > Please explain what "get  moved"  means.  Is  this  planned  but  not
> > started  yet?  work  in  progress?  who  is  working  on  it?  who is
> > discussing these things? where does such discussion take place?  I've
> > seen  nothing  like  this on lkml? what must one do to participate in
> > such discussions?
>
> A hypotheical.  Not that the serial drivers shouldn't be moved to the
> new serial infrastructure that'll c&p bugs...

Let me repeat: who  is  discussing  these  things?  where  does  such
discussion take place? I've seen nothing like this on lkml? what must
one do to participate in such discussions?

> Can you rephrase that?  What I was saying is that frequently Paul has
> pointed to something done outside of the 8xx / 8260 world and asked if

Where has this frequent discussion taken place? I don't remember I've
seen it here on the list, nor on lkml (well, I might have  missed  it
on lkml).


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In the beginning there was nothing.
And the Lord said "Let There Be Light!"
And still there was nothing, but at least now you could see it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
