Date: Mon, 3 May 1999 07:56:45 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: "Jason Y. Sproul" <jsproul@mail.wesleyan.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Mozilla for PPC
In-Reply-To: <Pine.GSO.4.05.9905021943190.2072-100000@mail.wesleyan.edu>
Message-ID: <Pine.LNX.4.10.9905030730010.1025-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Sun, 2 May 1999, Jason Y. Sproul wrote:

> 
> Tom Vier <nester@erols.com> posted back in March about the need for someone
> to hack up a PowerPC linkage function for XPCOM. Netscape's XPCOM will be
> essential to Mozilla in the near future, and the functions in question are
> only a few dozen lines long. I've been in touch with the module owner about
> doing this, but I won't be able to work on it for at least a week or two
> (possibly more). I'm also not familiar with LinuxPPC calling conventions
> (although I am familiar with other ABIs, and with PPC asm).
> 
> Furthermore, it appears that a pre-R5 glibc2 system is necessary to make
> Mozilla work at all, and I've yet to set that up. I've got a partition I
> can use, but I have to clean it up and download and install pre-R5. And
> hopefully R5 will be out soon anyway.
> 
> Does someone else want to volunteer for this? Alternatively, could anyone
> point me to a good reference on the LinuxPPC ABI? Extra bonus points if you
> can make Mozilla work on my R4 system... Thanks!
> 
> ........................................................................
> Jason Y. Sproul                    http://www.con.wesleyan.edu/~jsproul/
> jsproul@wesleyan.edu            jsproul@iced.com    http://www.iced.com/
>      Eagles may soar, but weasels don't get sucked into jet engines.
> 
> 

Mozilla works fine under R4, i am using the XFree libs so i am not sure
if it will work with the X libs installed with R4 (you are going to need
a newer version anyways since the default libs aren't thread safe). 
I do have an rpm of mozilla (built with no changes from the R5 srpm) if
you want it.

  Kostas Gewrgiou.




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
