Date: Mon, 19 Jul 1999 11:35:38 -0400 (EDT)
From: "P. Barrette" <barretp@mcmail.cis.McMaster.CA>
To: Paul.Mackerras@cs.anu.edu.au
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user-digest@lists.linuxppc.org
Subject: Re: some progress: opening display /platinum@F8000000... failed
In-Reply-To: <199907190226.MAA01159@tango.anu.edu.au>
Message-ID: <Pine.SOL.3.96.990719113343.2742C-100000@mcmail.cis.McMaster.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks for the reply, I have never actually seen OF before, I've been
doing it blind for a year or so, but that makes sense.  Kind of ironic
that I have the problems now that I can see the errors;-)  I have that new
driver I'll try it out.

--------
Paul Barrette
Ph.D. Candidate Classics (Latin Literature)
System Administrator
McMaster University

"Oppositaque ad os manu nescio quid taetrum 
exsibilavit, quod postea Graecum esse affirmabat."
                                      --Petronius

On Mon, 19 Jul 1999, Paul Mackerras wrote:

> Paul Barrette <barretp@mcmail.cis.mcmaster.ca> wrote:
> 
> > NB it gave me the same problem! opening display /platinum@F8000000... failed
> 
> That message is a bit of a red herring, all it is telling you is that
> OF doesn't have a method for initializing the platinum, but you knew
> that anyway.  It just means that you can't use the video=ofonly
> option.
> 
> There are some problems with the platinumfb driver.  Mark Abene posted
> a message recently with a better version of the platinumfb driver.
> 
> Paul.
> 
> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
