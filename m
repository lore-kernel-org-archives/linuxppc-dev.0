From: "Campbell, Marc" <CAMPBMA1@mail.northgrum.com>
Reply-To: "Campbell, Marc" <campbma1@mail.northgrum.com>
To: "Robert G. Werner" <rwerner@lx1.microbsys.com>
Cc: linuxppc-dev@lists.linuxppc.org
Message-ID: <36D3280F.6A8B241A@mail.northgrum.com>
Date: Tue, 23 Feb 1999 17:13:39 -0500
MIME-Version: 1.0
Subject: Re: PowerPC Beowulf Who?
References: <Pine.LNX.3.96.990222221152.1258A-100000@lx1.microbsys.com>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


There are several issues.  Some PPC specific and some not.

General issues would include the ability to procure turn key system and software revision support.

PPC specific issues start with the assurance that the necessary  libs (e.g. MPI) have been checked out on PPC hardware clusters.

Another PPC issue is cluster communication.  In some cases standard ethernet is not enough cluster bandwidth.  In what case does FireWire make sense in a PPC Beowulf (Linux) cluster?  Is Myrinet (www.myri.com) a more appropriate clustering communication system? If Myrinet, then where are the LinuxPPC or YDL drivers?  Myrinet lists Alpha Linux and x86 Linux but NOT PPC Linux (http://www.myri.com:80/GM/).

Who is taking initiative in the PowerPC/AltiVec Beowulf (Linux clustering) area?

-- Marc

Marc Campbell
Northrop Grumman
Technology Development
High Performance Computing, Group Lead
Melbourne, FL

campbma1@mail.northgrum.com

"Robert G. Werner" wrote:

> Are the issues that different for PPC than for the other architectures that you
> need to special attention on this matter?  My understanding was that the
> clustering techniques used for Beowulf were based on standard libs (PVM,
> IIRC).  Thus the issues seem like they should be pretty much the same as on any
> other HW baring Networking HW questions.
> Am I way off base here?
>
> Robert G. Werner
> rwerner@lx1.microbsys.com
> Impeach Conggress!!
>
> To believe your own thought, to believe that what is true for
> you in your private heart is true for all men -- that is genius.
>                 -- Ralph Waldo Emerson
>
> On Mon, 22 Feb 1999, Campbell, Marc wrote:
>
> >
> > Any suggestions on who to contact for PowerPC & PowerPC/AltiVec Beowulf development, integration, sales, and/or support?
> >
> > Marc Campbell
> > Northrop Grumman
> > Technology Development
> > High Performance Computing, Group Lead
> > Melbourne, FL
> >
> > campbma1@mail.northgrum.com
> >

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
