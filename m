Date: Mon, 03 May 1999 13:56:08 -0500 (CDT)
From: puetzk6715@uni.edu
Subject: Re: local.h header file.
In-reply-to: <372D3AAD.3C76AF99@wanadoo.fr>
To: Martin Costabel <costabel@wanadoo.fr>
Cc: =?iso-8859-1?Q?Marc=2DAndr=E9?= Fortin <simafinc@globetrotter.qc.ca>,
        linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.PMDF.3.96.990503135548.540345761G-100000@uni.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=DEC-MCS
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Isn't this stuff in the kernel source?

On Mon, 3 May 1999, Martin Costabel wrote:

> 
> > Marc-André Fortin wrote:
> > 
> > Can somebody tell me if there is a file called local.h in RedHat Linux
> > 5.2? (if yes, where it is?)
> > 
> > Or maybe the parameter I'm looking for (MAX_OPEN_FILES) is somewhere
> > else?
> > 
> > Should I use the grep command to find files containing a specific
> > string? Is (grep) looks in all the subdirectories?
> > (I' tried, but no luck)
> 
> To look for a string in all the *.h files in all subdirectories, you can
> do
> 
>    find . -name "*.h" -print | xargs grep MAX_OPEN
> 
> or some abbreviation thereof (you can omit the '.' and '-print').
> 
> I didn't find any local.h nor MAX_OPEN_FILES here, BTW.
> 
> --
> Martin
> 
> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
