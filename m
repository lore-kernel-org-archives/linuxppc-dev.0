Date: Thu, 15 Jun 2000 23:19:07 -0700 (PDT)
From: Brad Midgley <brad@turbolinux.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: paul-rsync: make zImage fails
In-Reply-To: <394988C9.92470C6F@denise.shiny.it>
Message-ID: <Pine.LNX.4.20.0006152313080.15387-100000@mail.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


it's been a long time since i've gotten a chrp image to work, but the
current sources can't do it:

main.c: In function `chrpboot':
main.c:43: conflicting types for `_start'
main.c:29: previous declaration of `_start'

is it an unfortunate name collision, or is one of these right and one
wrong?

 extern char _start[], _end[];
   ...
 extern char _start;

Brad
Turbolinux Frontier Group
brad@turbolinux.com | http://www.turbolinux.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
