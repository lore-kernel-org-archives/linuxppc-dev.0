Date: Tue, 27 Jul 1999 14:48:03 -0600 (CST)
From: Kamran Karimi <karimi@cs.uregina.ca>
To: Tom Rini <trini@disparity.net>
cc: Paul Mackerras <paulus@cs.anu.edu.au>, linuxppc-dev@lists.linuxppc.org
Subject: Re: DIPC for PowerPC
In-Reply-To: <Pine.BSF.3.96.990727164140.1221R-100000@silver.teardrop.net>
Message-ID: <Pine.SGI.3.91.990727144404.15510A-100000@MERCURY.CS.UREGINA.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 27 Jul 1999, Tom Rini wrote:

> >  Thanks. I'll incorporate your changes ASAP. Is there a way to determine 
> > at kernel compile time whether the machine is 32 bit or 64 bit?
> 
> It's called CONFIG_PPC64 right now I think..

 Thanks. I have put a test package (dipc-1.1d.tgz) with the needed 
changes for downloading and test. Thanks to Paul the user-space 
applications in the package should now be compilable under glibc.

 The package is available by anonymous ftp from orion.cs.uregina.ca 
/pub/dipc.

-Kamran

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
