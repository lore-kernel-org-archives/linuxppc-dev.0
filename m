Message-ID: <XFMail.990607003153.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.10.9906062143070.4301-100000@mercator.cs.kuleuven.ac.be>
Date: Mon, 07 Jun 1999 00:31:53 +0100 (BST)
From: Gary Thomas <gdt@linuxppc.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
Subject: RE: gdb 4.18-1
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 06-Jun-99 Geert Uytterhoeven wrote:
> 
> 
> Gdb 4.18-1 (from Debian potato) doesn't seem to beable to debug anymore :-(
> 
>| [21:40:51]/home/geert/em86# gdb em86
>| GNU gdb 4.18
>| Copyright 1998 Free Software Foundation, Inc.
>| GDB is free software, covered by the GNU General Public License, and you are
>| welcome to change it and/or distribute copies of it under certain conditions.
>| Type "show copying" to see the conditions.
>| There is absolutely no warranty for GDB.  Type "show warranty" for details.
>| This GDB was configured as "powerpc-unknown-linux-gnu"...
>| (gdb) run
>| Starting program: /export/home0/geert/em86/em86 
>| Don't know how to run.  Try "help target".
>   ^^^^^^^^^^^^^^^^^^^^
>| (gdb) 
> 
> Any clues?
> 

Where did you get GDB-4.18?  I had to make _many_ patches to
get Linux/PPC support in there.

You can pick this up (the SRPM at least) from:
  ftp://ftp.linuxppc.org/linuxppc/users/gdt/

BTW - I'll be passing these changes on to the GDB maintainers soon.

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
