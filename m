Message-ID: <XFMail.990329155456.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.10.9903290441460.22943-100000@beer.pub.umich.edu>
Date: Mon, 29 Mar 1999 15:54:56 +0100 (BST)
From: Gary Thomas <gdt@linuxppc.org>
To: Satadru Pramanik <satadru@umich.edu>
Subject: RE: /usr/include files
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 29-Mar-99 Satadru Pramanik wrote:
> 
> Exactly wher can I get a copy of all the files in the /usr/include dir?  I
> have egcs 1.1.2, and glibc 2.1, and my compilation of MySQL is failing due
> to problems with the files in that dir.   I already have my
> /usr/include/linux dir symlinked to a cvs updated src dir, so I just need
> to get these include files fixed, I think.   Which rpm file would this be
> in?  I have the RedHat 5.9 Starbuck SRPMS files, so I just need to know
> which one to use.
> 

These files come from a myriad of sources.

The primary ones come from the GLIBC-devel package.
Others, such as the include files for TCL/TK, would come from other assorted
packages.

What kind of problems are you having?  details, please.

------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
