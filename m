Date: Thu, 19 Aug 1999 14:12:33 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: string.h conflicting types warnings
Message-ID: <Pine.LNX.3.96.990819141202.8759P-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
                     
I'm working on a standalone driver and have been running into these
warnings lately.  Whilst compiling Mac-on-Linux I also got these
warnings as well.  Searching around I only found some netbsd folks
gettings these same warnings.  Anyone have an idea where this comes from? 
                     
Thanks - Matt
                     
------------
                    
cc -DLINUX -D__KERNEL__ -DMODULE -Wall -O2 -I/usr/include  -I.  -c
stack_linux.c -o stack_linux.o
In file included from /usr/include/linux/signal.h:64,
                 from /usr/include/linux/sched.h:23,
                 from cnet_linux.h:52,
                 from globals.h:200,
                 from stack_linux.c:39:
/usr/include/linux/string.h:31: warning: conflicting types for built-in
function `memset'
/usr/include/linux/string.h:32: warning: conflicting types for built-in
function `memcpy'
/usr/include/linux/string.h:35: warning: conflicting types for built-in
function `memcmp'

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
