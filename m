Message-ID: <366CBDC9.6BCB3C57@bivwood.com>
Date: Tue, 08 Dec 1998 00:48:57 -0500
From: "Mohammad A. Haque" <mhaque@bivwood.com>
MIME-Version: 1.0
To: "Tim Perdue, The Des Moines City.net" <tim@dmcity.net>
CC: php3@lists.php.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: Compilation Problems - PHP / APACHE
References: <005e01be2251$f0d3a490$61246ccf@timnt.desm.uswest.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Did you compile php with ORACLE support?

--Mohammad

"Tim Perdue, The Des Moines City.net" wrote:
> 
> I still have not solved my compilation problems with PHP 3.0.5 / Apache
> 1.3.3
> 
> Apache compiles fine by itself, but if you try to compile it with support
> for PHP, I get these errors. I'm seriously stuck on this one - for over a
> day now.
> 
> Any takers?
> 
> This is what I get when I MAKE apache, after having made and installed PHP
> (successfully).
> 
> util.c: In function `ap_find_token':
> util.c:1015: `test_char_table' undeclared (first use this function)
> util.c:1015: (Each undeclared identifier is reported only once
> util.c:1015: for each function it appears in.)
> util.c:1015: `T_HTTP_TOKEN_STOP' undeclared (first use this function)
> util.c: In function `ap_escape_shell_cmd':
> util.c:1074: `test_char_table' undeclared (first use this function)
> util.c:1074: `T_ESCAPE_SHELL_CMD' undeclared (first use this function)
> util.c: In function `ap_escape_path_segment':
> util.c:1198: `test_char_table' undeclared (first use this function)
> util.c:1198: `T_ESCAPE_PATH_SEGMENT' undeclared (first use this function)
> util.c: In function `ap_os_escape_path':
> util.c:1227: `test_char_table' undeclared (first use this function)
> util.c:1227: `T_OS_ESCAPE_PATH' undeclared (first use this function)
> make[3]: *** [util.o] Error 1
> make[2]: *** [subdirs] Error 1
> make[2]: Leaving directory `/tmp/apache_1.3.3/src'
> make[1]: *** [build-std] Error 2
> make[1]: Leaving directory `/tmp/apache_1.3.3'
> make: *** [build] Error 2

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
