Date: Wed, 24 Feb 1999 22:06:56 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: "Robert G. Werner" <rwerner@lx1.microbsys.com>
cc: "Campbell, Marc" <CAMPBMA1@mail.northgrum.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerPC Beowulf Who?
In-Reply-To: <Pine.LNX.3.96.990223143830.3620A-100000@lx1.microbsys.com>
Message-ID: <Pine.LNX.4.04.9902242145360.503-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 23 Feb 1999, Robert G. Werner wrote:

> 
> I'm pretty new to Beowulf myself but I haven't ran across any groups
> specifically oriented toward supporting PPC.  
> 
> As in regards to the General Beowulf:
> Turnkey systems for Beowulf are still a new phenomenon.  Most of the famous
> clusters I've ever heard of were hand built.  
> I've heard of some companies (don't remember names) that will sell turnkey 
> systems but I'm assuming those are IA32 or Aplha.
> What exactly do you mean by SW revision support?
> 
> On the PPC:
> IIRC Firewire isn't even working under LinuxPPC as a regular interface yet.  
> Looking into using it for networking in a Beowulf cluster is a bit 
> premature IMHO.  Is there even any commercial HW for this?
> I really do have a hunch that once you can get Firewire,  say,  to work with 
> Linux on PPC,  then it will be trivial to make it work with the clustering
> libs.

I wouldn't hold out high hopes for firewire.. Fast ethernet and Gigabit
ethernet are both much more cost effective, and available now. One of the
things that makes fast ethernet work so well for Beowulf applications is
the price/performance one can get with fast ethernet switches. Gigabit
ethernet is quickly getting very affordable also.

I doubt firewire switches will be available any time in the near future,
not to mention TCP/IP support for firewire.

> 
> Check out the Linux Paralale-HOWTO 
> (at http://metalab.unc.edu/mdw/HOWTO/Parallel-Processing-HOWTO-2.html) 
> for some information on who is developing the non-ethernet networking 
> technologies for clustering.  Perdue is big in this field,  IIRC.  They have 
> a nice technique using the paralale port for networking even(PAPERS).
> As far as I know,  all of these are great questions but Beowulf clustering
> technology is still experimental enough that many of your questions haven't 
> been completely answered for IA32 and Alpha let alone PPC.  
> Again,  I'm not an expert.  Just an enthusiastic beginer like yourself.
> 

Also see http://www.scl.ameslab.gov/Projects/ClusterCookbook/

Actually, I would say Beowulf applications are quite useable.. I work at
the Scalable Computing Lab (the above url), and we regularly users running
scientific applications on a 64 node Pentium Pro cluster.

> BTW,  what applications are you looking to use your cluster for?  Do you have a
> specific task in mind or are you just looking to make sure that LinuxPPC can do
> clusters too?
> 
> Robert G. Werner
> rwerner@lx1.microbsys.com
> Impeach Conggress!!
> 
> "Just think, with VLSI we can have 100 ENIACS on a chip!"
> -- Alan Perlis
> 
> On Tue, 23 Feb 1999, Campbell, Marc wrote:
> 
> > There are several issues.  Some PPC specific and some not.
> > 
> > General issues would include the ability to procure turn key system and software revision support.
> > 
> > PPC specific issues start with the assurance that the necessary  libs (e.g. MPI) have been checked out on PPC hardware clusters.
> > 
> > Another PPC issue is cluster communication.  In some cases standard ethernet is not enough cluster bandwidth.  In what case does FireWire make sense in a PPC Beowulf (Linux) cluster?  Is Myrinet (www.myri.com) a more appropriate clustering communication
>  system? If Myrinet, then where are the LinuxPPC or YDL drivers?  Myrinet lists Alpha Linux and x86 Linux but NOT PPC Linux (http://www.myri.com:80/GM/).
> > 
> > Who is taking initiative in the PowerPC/AltiVec Beowulf (Linux clustering) area?

It seems the Linux clustering area is a rather small (but quickly growing)
niche, and the PPC niche even smaller. To compound the problem, PPC
hardware either isn't supported very well under Linux (the new Apple
G3's), or is expensive (Motorola's MTX boards). This isn't to say the new
G3's won't get support eventually, but by the time it's available, the
hardware is old. Someone building a cluster wants it to work ASAP, and
doesn't want year-old hardware.

I personally think the Motorola MTX boards would be terrific for clusters
since one could rack mount the boards on an approximately 2-3 inch
spaceing since SCSI and fast ethernet are built on the board. Then there's
the bonus that they only draw 30 watts for a dual 604e, cutting down on
cooling and power bills. The only difficulty is you're going to pay about
twice what a similiar Pentium II cluster will cost. (of course, rack
mounting PII's isn't exactly cheap either)

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
