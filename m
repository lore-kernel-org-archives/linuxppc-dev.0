From: "John Que" <qwejohn@hotmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: cross compiling a complex project 
Date: Mon, 03 May 2004 11:59:49 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY14-F15dPULDvYqNC0000a732@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
I had build a cross compiler for embedded linux which runs on embedded
powerPC.

It works ok on simple sample programs I wrote, like
"hello world", etc, which do not use other libs.

Now I want to use it to build some more complex projects (the complexity is
relative
to the samples I wrote, of course).
I mean projects which have autocinf configure scripts.
Like , for example ,  speex audio codec , or Midnight Commander.

Now , it has not have in its configure script the type of ppc I
use.

On the other hands, it uses other libraries (speex uses oggs for example).

one way is to configure it with no target, and afterwards change the
makefile.
But this seems not an easy task.
I googled the net for solutions.

I saw one solution in http://www.scratchbox.org/

but is says there
"Supports ARM, x86 and PowerPC targets (PowerPC is experimental at this
time)"
So i hesitate a little.
does anybody has experience with a task like that (on powerpc) and using
tools
for that task (like that scratchbox or other?)

regards
Q.  John


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
