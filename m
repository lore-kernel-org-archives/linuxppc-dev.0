In-Reply-To: <Pine.LNX.3.96.990322113136.7474C-100000@globegate.utm.edu>
Date: Mon, 22 Mar 1999 18:55:12 +0100
To: "David A. Gatwood" <marsmail@globegate.utm.edu>,
        linuxppc-dev@lists.linuxppc.org, gilbert@apple.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Generic problem with BootX
Message-Id: <19990322185512.028278@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Mar 22, 1999, David A. Gatwood <marsmail@globegate.utm.edu> wrote:

>Please, if you do this, please make it do a similar reset before booting
>MkLinux.  The stock G3 UW cards have been a thorn in our side for the same
>reason.

Unfortunately, I can't do that easily without having the source code for
MkLinux booter. I cannot reset the NCR chip before running the MkLinux
booter plugin since this must be done _very_ late in the boot process. I
may be able to patch it since it's 68k code but this will definitely take
time.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
