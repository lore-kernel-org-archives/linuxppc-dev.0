Message-ID: <XFMail.981220110540.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <199812200348.LAA24006@mule.wantree.com.au>
Date: Sun, 20 Dec 1998 11:05:40 -0000 (GMT)
From: Gary Thomas <gdt@linuxppc.org>
To: Keith Jacob <kjacob@wantree.com.au>
Subject: RE: undefined symbol: _IO_2_1_stdin_
Cc: linuxppc-user list <linuxppc-user@lists.linuxppc.org>
Cc: linuxppc-user list <linuxppc-user@lists.linuxppc.org>,
        linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
        linux-pmac list <linux-pmac@samba.anu.edu.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


What libraries (GLIBC) do you have installed?

On 20-Dec-98 Keith Jacob wrote:
> 
> Any clues? Please?
> 
> Full errror is
> 
> error in loading shared libraries
>: undefined symbol: _IO_2_1_stdin_
> 
> When?
> 
> Whenever I try to run pre-compiled binaries (mostly from stock LinuxPPC 
> RPMs) from late-1998 builds.
> 
> BTW, Gary Thomas's latest egcs-1.1-1b RPMs include bins that exhibit this 
> behaviour, e.g. gcc!
> 
> When I was using egcs-1.0-2e, and R4 packages there were no probs with 
> bins I compiled myself.
> 

------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
