Message-ID: <00b601be2167$9edffca0$61246ccf@timnt.desm.uswest.net>
Reply-To: "Tim Perdue, The Des Moines City.net" <tim@dmcity.net>
From: "Tim Perdue, The Des Moines City.net" <tim@dmcity.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: PHP / Apache
Date: Sun, 6 Dec 1998 16:27:34 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been having a hard time compiling software on LinuxPPC. It took a lot
of hacking and research to make MySQL compile, and PHP compiled fairly
easily.

But apache will not compile cleanly when I am including the PHP module.

I see there is a successful RPM out there for Apache 1.3.3, so that can't be
the problem. The problem with my compile must be related to PHP?

Anyone have any idea what this error is? Please be specific with your
responses, including any libraries I need and suggestions on where to get
them.

Please respond to tim@dmcity.net

Thank you!

util.c: In function `ap_find_token':
util.c:1015: `test_char_table' undeclared (first use this function)
util.c:1015: (Each undeclared identifier is reported only once
util.c:1015: for each function it appears in.)
util.c:1015: `T_HTTP_TOKEN_STOP' undeclared (first use this function)
util.c: In function `ap_escape_shell_cmd':
util.c:1074: `test_char_table' undeclared (first use this function)
util.c:1074: `T_ESCAPE_SHELL_CMD' undeclared (first use this function)
util.c: In function `ap_escape_path_segment':
util.c:1198: `test_char_table' undeclared (first use this function)
util.c:1198: `T_ESCAPE_PATH_SEGMENT' undeclared (first use this function)
util.c: In function `ap_os_escape_path':
util.c:1227: `test_char_table' undeclared (first use this function)
util.c:1227: `T_OS_ESCAPE_PATH' undeclared (first use this function)
make[3]: *** [util.o] Error 1
make[2]: *** [subdirs] Error 1
make[2]: Leaving directory `/tmp/apache_1.3.3/src'
make[1]: *** [build-std] Error 2
make[1]: Leaving directory `/tmp/apache_1.3.3'
make: *** [build] Error 2


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
