Date: Tue, 23 Feb 1999 15:22:13 -0800 (PST)
From: "Robert G. Werner" <rwerner@lx1.microbsys.com>
To: "Campbell, Marc" <CAMPBMA1@mail.northgrum.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerPC Beowulf Who?
In-Reply-To: <36D3280F.6A8B241A@mail.northgrum.com>
Message-ID: <Pine.LNX.3.96.990223143830.3620A-100000@lx1.microbsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm pretty new to Beowulf myself but I haven't ran across any groups
specifically oriented toward supporting PPC.  

As in regards to the General Beowulf:
Turnkey systems for Beowulf are still a new phenomenon.  Most of the famous
clusters I've ever heard of were hand built.  
I've heard of some companies (don't remember names) that will sell turnkey 
systems but I'm assuming those are IA32 or Aplha.
What exactly do you mean by SW revision support?

On the PPC:
IIRC Firewire isn't even working under LinuxPPC as a regular interface yet.  
Looking into using it for networking in a Beowulf cluster is a bit 
premature IMHO.  Is there even any commercial HW for this?
I really do have a hunch that once you can get Firewire,  say,  to work with 
Linux on PPC,  then it will be trivial to make it work with the clustering
libs.

Check out the Linux Paralale-HOWTO 
(at http://metalab.unc.edu/mdw/HOWTO/Parallel-Processing-HOWTO-2.html) 
for some information on who is developing the non-ethernet networking 
technologies for clustering.  Perdue is big in this field,  IIRC.  They have 
a nice technique using the paralale port for networking even(PAPERS).
As far as I know,  all of these are great questions but Beowulf clustering
technology is still experimental enough that many of your questions haven't 
been completely answered for IA32 and Alpha let alone PPC.  
Again,  I'm not an expert.  Just an enthusiastic beginer like yourself.

BTW,  what applications are you looking to use your cluster for?  Do you have a
specific task in mind or are you just looking to make sure that LinuxPPC can do
clusters too?

Robert G. Werner
rwerner@lx1.microbsys.com
Impeach Conggress!!

"Just think, with VLSI we can have 100 ENIACS on a chip!"
-- Alan Perlis

On Tue, 23 Feb 1999, Campbell, Marc wrote:

> There are several issues.  Some PPC specific and some not.
> 
> General issues would include the ability to procure turn key system and software revision support.
> 
> PPC specific issues start with the assurance that the necessary  libs (e.g. MPI) have been checked out on PPC hardware clusters.
> 
> Another PPC issue is cluster communication.  In some cases standard ethernet is not enough cluster bandwidth.  In what case does FireWire make sense in a PPC Beowulf (Linux) cluster?  Is Myrinet (www.myri.com) a more appropriate clustering communication
 system? If Myrinet, then where are the LinuxPPC or YDL drivers?  Myrinet lists Alpha Linux and x86 Linux but NOT PPC Linux (http://www.myri.com:80/GM/).
> 
> Who is taking initiative in the PowerPC/AltiVec Beowulf (Linux clustering) area?
> 
> -- Marc
> 
> Marc Campbell
> Northrop Grumman
> Technology Development
> High Performance Computing, Group Lead
> Melbourne, FL
> 
> campbma1@mail.northgrum.com
> 
> "Robert G. Werner" wrote:
> 
> > Are the issues that different for PPC than for the other architectures that you
> > need to special attention on this matter?  My understanding was that the
> > clustering techniques used for Beowulf were based on standard libs (PVM,
> > IIRC).  Thus the issues seem like they should be pretty much the same as on any
> > other HW baring Networking HW questions.
> > Am I way off base here?
> >
> > Robert G. Werner
> > rwerner@lx1.microbsys.com
> > Impeach Conggress!!
> >
> > To believe your own thought, to believe that what is true for
> > you in your private heart is true for all men -- that is genius.
> >                 -- Ralph Waldo Emerson
> >
> > On Mon, 22 Feb 1999, Campbell, Marc wrote:
> >
> > >
> > > Any suggestions on who to contact for PowerPC & PowerPC/AltiVec Beowulf development, integration, sales, and/or support?
> > >
> > > Marc Campbell
> > > Northrop Grumman
> > > Technology Development
> > > High Performance Computing, Group Lead
> > > Melbourne, FL
> > >
> > > campbma1@mail.northgrum.com
> > >
> 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
