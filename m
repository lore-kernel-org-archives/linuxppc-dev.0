Message-ID: <20010106022001.34890.qmail@web11704.mail.yahoo.com>
Date: Sat, 6 Jan 2001 10:20:01 +0800 (CST)
From: Micael balow <micaelbalow@yahoo.com.cn>
Subject: ppcboot Questions
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Sir,
      I am a freshman of the development of embedded
system, and it is my honor to contact with you .
      I have already had a custom PBX board with a
embedded CPU named MPC823, and a monitor has already
been flashed into a EPROM on the board.
      I'd like to ask you the following questions.
      1.I think,in order to get a kernel image and let
it run on that board,I need a Linux OS with a right
version to complie a kernel. When I used Redhat 6.0
and 6.1 Linux to make ppcboot.0.4.4-pre1,I got the
following error mesages:

>      Makefile:24:***unterminated call to >function
'shell' : missing '('. stop.

     But when I use Redhat 6.2 Linux to make
ppcboot.0.4.4-pre1,the message is something like the
following:

>Make[1]:Entering directory '/ppcboot/ppc'
>Make[1]:'.depend' is up to date.
            ...
>Make[1]:Entering directory '/ppcboot/tools'
>Make[1]:***No rule to make target 'crc32.c'needed >by
'.depend'. stop.
>Make[1]:Leaving directory '/ppcboot/tools'

     I do not  know the reason that I got so much
error messages.Did I use the wrong Linux version? Did
I use the wrong Bash version? How can I make changes
to let it run well.

     Thank you for your reading my letter and thank
you for your considering my questions. I’d like to
expect to get answers as soon as possible. Thank you
very much.

      Best Regards

                      yours sincerely  Micael Balow


_________________________________________________________
Do You Yahoo!? 登录免费雅虎电邮! http://mail.yahoo.com.cn
创建雅虎俱乐部，真我个性尽施展！http://cn.clubs.yahoo.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
