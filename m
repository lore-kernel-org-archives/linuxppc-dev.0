Date: Wed, 13 Jan 1999 13:24:39 -0500 (EST)
From: satadru pramanik <satadru@umich.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: compiler errors
Message-ID: <Pine.LNX.4.05.9901131322170.10086-100000@beer.pub.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was compiling glib-1.1.2, and came up with an internal compiler error.
I have glibc .961212-1o

Should I complain, or move on to glibc2?
Errors:
testglib.c:966: internal error--unrecognizable insn:
(insn 9133 9130 9134 (set (mem:SI (plus:SI (reg:SI 16 r16)
                (const_int 65536)))
        (reg:SI 17 r17)) -1 (insn_list 5710 (insn_list 9130 (insn_list:REG_DEP_OUTPUT 5741 (insn_list:REG_DEP_OUTPUT 5713 (insn_list:REG_DEP_OUTPUT 5729 (insn_list:REG_DEP_OUTPUT 5736 (insn_list:REG_DEP_OUTPUT 5752 (insn_list:REG_DEP_OUTPUT 5764 (insn_list:REG_DEP_OUTPUT 5759 (insn_list:REG_DEP_OUTPUT 5772 (insn_list:REG_DEP_OUTPUT 5784 (insn_list:REG_DEP_OUTPUT 5779 (insn_list:REG_DEP_OUTPUT 5799 (insn_list:REG_DEP_OUTPUT 9126 (insn_list:REG_DEP_OUTPUT 9129 (nil))))))))))))))))
    (nil))
toplev.c:1360: Internal compiler error in function fatal_insn
make: *** [testglib.o] Error 1
[user@real glib-1.1.12]# 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
