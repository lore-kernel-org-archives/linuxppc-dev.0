Mime-Version: 1.0
Message-Id: <v04220800b4568b66a977@[129.105.9.226]>
Date: Mon, 15 Nov 1999 23:14:03 -0600
To: linuxppc-dev@lists.linuxppc.org
From: Geoff Hutchison <ghutchis@wso.williams.edu>
Subject: Re: Building Question
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I don't know if this is the right place for this, so if it isn't 
please just point me in the right direction.

I'm the head maintainer for the ht://Dig project and I do all of my 
development and compilation on my LinuxPPC R5 partition. We recently 
switched to using libtool, allowing shared and static libraries.

Increasingly, I get compilation failures like this:

../htlib/.libs/libht.a(conf.l.o): In function `yyinput(void)':
/home/ghutchis/htdig-cvs/build/htlib/conf.l.cc:1312: undefined 
reference to `yywrap'
/home/ghutchis/htdig-cvs/build/htlib/conf.l.cc:1312: relocation 
truncated to fit: R_PPC_REL24 yywrap
collect2: ld returned 1 exit status

I've seen the "R_PPC_REL24" failure before and it seems to happen 
frequently. I can't seem to find any reference on what the code means 
or how I can fix it. Generally, these failures don't happen for 
people running Linux/x86.

Thanks in advance,
-Geoff Hutchison
Williams Students Online
http://wso.williams.edu/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
