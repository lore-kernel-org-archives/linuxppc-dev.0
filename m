Date: Fri, 14 Nov 2003 16:44:19 -0600
Subject: Re: powerpc-linux-ar not found?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-dev@lists.linuxppc.org
To: Stefan Jeglinski <jeglin@4pi.com>
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <p06010202bbdad56b46c0@[192.168.0.254]>
Message-Id: <1543B52C-16F4-11D8-A74D-000A95A0560C@us.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Friday, Nov 14, 2003, at 16:28 US/Central, Stefan Jeglinski wrote:
> http://penguinppc.org/embedded/cross-compiling/
>
> I'm compiling on a Pentium box running 2.4.18 and gcc 2.96 from a
> Redhat 7.3 install.
>
> binutils-2.14.90.0.7 makes OK (it looked like the latest version). I
> got gcc 3.3.2 and when trying to build the bootstrap I error out:
>
> make[2] powerpc-linux-ar: Command not found

Put the directory into which you installed powerpc-linux-ar (you did
make install, right?) in your $PATH.

--
Hollis Blanchard
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
