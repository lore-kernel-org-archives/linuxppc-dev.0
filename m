MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14203.32991.275353.39293@ipa.ne.mediaone.net>
Date: Thu, 1 Jul 1999 10:53:19 -0400 (EDT)
From: R Shapiro <reshapiro@mediaone.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: trouble compiling fvwm in R5: strcmp and friends
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When compiling fvwm under R5, I'm getting errors wherever it uses the
basic string comparison functions: strcmp, strncmp, strcasecmp, etc.
For instance, compiling fvwm/fvwm.c dies as follows:

fvwm.c: In function `main':
fvwm.c:359: `_' undeclared (first use in this function)
fvwm.c:359: (Each undeclared identifier is reported only once
fvwm.c:359: for each function it appears in.)
fvwm.c:359: parse error before `const'
fvwm.c:359: parse error before `)'


The line in question is 

    if (strncasecmp(argv[i],"-debug",6)==0)

A similar problem occurs later in a reference to strcmp.

/usr/include/string.h looks perfectly normal, and other referenced
functions in string.h (eg strstr) don't cause any problem.

What's going on here? 

This is brand new by-the-book R5 installation.

-- 
reshapiro@mediaone.net
rshapiro@bbn.com


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
