In-Reply-To: <36F69C36.9D5373CE@business.wm.edu>
Date: Tue, 23 Mar 1999 13:27:47 +0100
To: "Kevin B. Hendricks" <kbhend@business.wm.edu>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: smbfs and smbmount and Paul's 2.2.1 kernel
Message-Id: <19990323132747.016080@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Mar 22, 1999, Kevin B. Hendricks <kbhend@business.wm.edu> wrote:

>To make smbfs work (I grabbed the src rpm and built it) I need to compile SMB
>_FS into the kernel.  I grabbed Paul's latest kernel source and dot.config
>file
>and noticed there was no support for SMB included in his kernel by default.
>
>Before I go and roll my own, has anyone played with mounting NT filesystems
>using smbmount and smbumount commands?  Is this stable on linuxppc?  Are
there
>any gotchas I should look out for with this filesystem?

I use it regulary, compiled as a module, and it seems to work (but
displays tons of messages in the active console). I had to compile recent
version of smbmount (from a 2.0 samba package, If I remember correctly),
the ones bundled with R4 didn't work with the latest kernel smbfs.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
