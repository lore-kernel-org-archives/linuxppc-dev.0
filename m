Message-ID: <XFMail.990417214812.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <fc.000f61e60004dff8000f61e60004dff8.4dffa@DEWEY.ESD113.WEDNET.EDU>
Date: Sat, 17 Apr 1999 21:48:12 +0100 (BST)
From: Gary Thomas <gdt@linuxppc.org>
To: (Josh Hudson) <Josh_Hudson@DEWEY.ESD113.WEDNET.EDU>
Subject: RE: Assembler Error
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 17-Apr-99 Josh Hudson wrote:
> 
> When I try to compile big codes with lots of lines I get this:
> 
> /tmp/cca00758.s: Assembler messages:
> /tmp/cca00758.s:40303: Error: Bad expression
> /tmp/cca00758.s:40303: Error: Rest of line ignored. First ignored
> character is `M'.
> make: *** [act_comm.o] Error 1  
> 
> 
> Can anyone help me fix this problem???
> 

Which version of the compiler/binutils?  You can get this via:
  rpm -qif `which cc`
  rpm -qif `which as`

Can you provide example code with a repeatable failing case?

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
