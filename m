Message-ID: <383130B3.FB987AD8@wanadoo.fr>
Date: Tue, 16 Nov 1999 11:23:47 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Geoff Hutchison <ghutchis@wso.williams.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Building Question
References: <v04220800b4568b66a977@[129.105.9.226]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geoff Hutchison wrote:

> Increasingly, I get compilation failures like this:
> 
> ../htlib/.libs/libht.a(conf.l.o): In function `yyinput(void)':
> /home/ghutchis/htdig-cvs/build/htlib/conf.l.cc:1312: undefined
> reference to `yywrap'
> /home/ghutchis/htdig-cvs/build/htlib/conf.l.cc:1312: relocation
> truncated to fit: R_PPC_REL24 yywrap
> collect2: ld returned 1 exit status
> 
> I've seen the "R_PPC_REL24" failure before and it seems to happen
> frequently. 

It happens after "undefined reference" errors.
 
>            I can't seem to find any reference on what the code means
> or how I can fix it. 

Fix the "undefined reference" error.

>                      Generally, these failures don't happen for
> people running Linux/x86.

You mean "undefined reference" isn't an error on x86? 

--:)
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
