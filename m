Message-ID: <3F955DCE.40907@kegel.com>
Date: Tue, 21 Oct 2003 09:24:46 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem cross-compiling for MPC860T on x86 host
References: <5.2.0.9.0.20031020095633.0271dec0@172.16.15.10>	 <20031020110913.30a1ac6d.damm@opensource.se> <1066750425.28407.9.camel@chuck.arlut.utexas.edu>
In-Reply-To: <1066750425.28407.9.camel@chuck.arlut.utexas.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthew S. McClintock wrote:
>>"L. Puneeth Rao" <puneeth_l@roc.co.in> wrote:
>>>         I have a MPC860T evaluation board, and i would like to load
>>>linux2.4 kernel. For this i have used a x86 system as host machine and
>>>followed the procedure prescribed in
>>>http://penguinppc.org/embedded/cross-compiling/. i have obtained 2.4.18
>>>kernel sources and applied the suggested patch ppc-patch-2.4.18 and
>>>additional tools used are gcc-core-3.3.1 and binutils-2.11.90.0.8. ...
>>>/usr/src/linux/include/asm/unistd.h:413: error: asm-specifier for variable
>>>`__sc_4' conflicts with asm clobber list
>
> I saw these warnings when I tried to use a compiler that was too new to
> compile to kernel. For the that was gcc 3.3.1 compiling linux 2.4.19.
> You may be seeing the same problem.

Yes.  See http://gcc.gnu.org/PR9379
A fix is included in linux-2.4.21, I think.
- Dan

--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
