From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: linuxppc-dev@lists.linuxppc.org,
        Josh_Hudson@DEWEY.ESD113.WEDNET.EDU (Josh Hudson)
Subject: Re: Assembler Error
Date: Sun, 18 Apr 1999 13:11:40 +0200
Content-Type: text/plain
References: <fc.000f61e60004dff8000f61e60004dff8.4dffa@DEWEY.ESD113.WEDNET.EDU>
MIME-Version: 1.0
Message-Id: <99041813221000.00903@ns1102.munich.netsurf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Sat, 17 Apr 1999 schrieb Josh Hudson:
>When I try to compile big codes with lots of lines I get this:
>
>/tmp/cca00758.s: Assembler messages:
>/tmp/cca00758.s:40303: Error: Bad expression
>/tmp/cca00758.s:40303: Error: Rest of line ignored. First ignored
>character is `M'.
>make: *** [act_comm.o] Error 1  

Any chance you are compiling with -ggdb? If so, turn it into a simple -g option
and it should work.
Another possibility might be that the sources you are trying to compile contain
inline assembler for a non-PPC processor.

If the above isn't true for you, post more information, like the exact options
used to compile the sourcefile, the preprocessed source file and/or the
assembler file. You can get the latter 2 if you add -save-temps to the compiler
options. If you compile a .c/.cc/.C file with -save-temps, you will get
the intermediate .i/.ii (preprocessed) and .s (assembler) files, which
are usually not visible.

Franz.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
