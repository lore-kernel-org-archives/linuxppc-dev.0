Date: Fri, 19 Feb 1999 08:54:44 -0500
From: Michael Meissner <meissner@cygnus.com>
To: Paul.Mackerras@cs.anu.edu.au
Cc: zankel@tarantel.rz.fh-muenchen.de, bh40@calva.net, davidsen@prodigy.com,
        cort@persephone.cs.nmt.edu, marsmail@globegate.utm.edu,
        dvdoug@tiac.net, paubert@iram.es, jskov@cygnus.co.uk, hozer@drgw.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [ppc-dev] Summary: Restructuring Efforts
Message-ID: <19990219085444.A1362@wogglebug.cygnus.com>
References: <36CCB670.CE42A873@mailserv.rz.fh-muenchen.de> <199902190612.RAA00610@tango.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199902190612.RAA00610@tango.anu.edu.au>; from Paul Mackerras on Fri, Feb 19, 1999 at 05:12:21PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 19, 1999 at 05:12:21PM +1100, Paul Mackerras wrote:
> 
> Christian Zankel <zankel@tarantel.rz.fh-muenchen.de> wrote:
> 
> > There should be another cvs tree used for developers. A lot of
> > (inofficial) patches are floating around. So, this tree can be used as
> > the common base where developers can start with their patches upon.
> 
> I think a CVS tree for developers is a good idea.  In fact I think we
> need two trees; one for developers to share their latest thoughts, and
> another one where we put stuff once it is tested and known not to
> break things for most users.  The second tree would then be the one
> from which patches get sent to Linus.

Why do people keep mentioning a second tree, and not using something like a
branch off of the main cvs tree?  Within egcs, we use branches for separate
development tasks (1.1.x and mainline).  In fact right now, I have my own
branch for the PowrerPC compiler changes.

-- 
Michael Meissner, Cygnus Solutions (Massachusetts office)
4th floor, 955 Massachusetts Avenue, Cambridge, MA 02139, USA
meissner@cygnus.com,	617-354-5416 (office),	617-354-7161 (fax)

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
