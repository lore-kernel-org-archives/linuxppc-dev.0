Date: Fri, 26 May 2000 19:01:59 -0400
From: Alain Birtz <abz@videotron.ca>
Subject: Shared memory between module and application: is it possible ?
To: linuxppc-dev@lists.linuxppc.org
Reply-to: abz@videotron.ca
Message-id: <392F0267.C7933983@videotron.ca>
MIME-version: 1.0
Content-type: text/plain; x-mac-creator=4D4F5353; x-mac-type=54455854; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


How application can do to exchange data with module ?

I know how to share memory between two application,
but when I try to make the samething with module and application
I get header confict:

----------------
In file included from /usr/include/sys/shm.h:24,
                 from mod_l1.c:9:
/usr/include/unistd.h:193: conflicting types for `ssize_t'
/usr/include/linux/types.h:37: previous declaration of `ssize_t'
In file included from /usr/include/sys/shm.h:25,
                 from mod_l1.c:9:
/usr/include/sys/types.h:46: conflicting types for `ino_t'
/usr/include/linux/types.h:11: previous declaration of `ino_t'
/usr/include/sys/types.h:57: conflicting types for `dev_t'
/usr/include/linux/types.h:10: previous declaration of `dev_t'
/usr/include/sys/types.h:72: conflicting types for `nlink_t'
/usr/include/linux/types.h:13: previous declaration of `nlink_t'
In file included from /usr/include/sys/types.h:193,
                 from /usr/include/sys/shm.h:25,
                 from mod_l1.c:9:
/usr/include/sys/select.h:51: conflicting types for `fd_set'
/usr/include/linux/types.h:9: previous declaration of `fd_set'
----------------

What can I do to fix it ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
