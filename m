Message-ID: <372D3AAD.3C76AF99@wanadoo.fr>
Date: Mon, 03 May 1999 07:57:01 +0200
From: Martin Costabel <costabel@wanadoo.fr>
Reply-To: costabel@wanadoo.fr
MIME-Version: 1.0
To: =?iso-8859-1?Q?Marc=2DAndr=E9?= Fortin <simafinc@globetrotter.qc.ca>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: local.h header file.
References: <01be9500$ac75ea20$2f90a98e@presario>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Marc-André Fortin wrote:
> 
> Can somebody tell me if there is a file called local.h in RedHat Linux
> 5.2? (if yes, where it is?)
> 
> Or maybe the parameter I'm looking for (MAX_OPEN_FILES) is somewhere
> else?
> 
> Should I use the grep command to find files containing a specific
> string? Is (grep) looks in all the subdirectories?
> (I' tried, but no luck)

To look for a string in all the *.h files in all subdirectories, you can
do

   find . -name "*.h" -print | xargs grep MAX_OPEN

or some abbreviation thereof (you can omit the '.' and '-print').

I didn't find any local.h nor MAX_OPEN_FILES here, BTW.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
