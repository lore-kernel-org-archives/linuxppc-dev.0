From: zjuzhou@163.net
MIME-Version: 1.0
Message-Id: <3AF7D69E.03527@bjapp1>
Date: Tue, 8 May 2001 19:21:02 +0800 (CST)
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RE: Uncompress Ok, but cannot run linux kernel...
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




> Tom:

> I stumbled into the same problem a while ago.
>
> While I did not use a hardware debugger I used the sample demonstrating
> serial output to find that the Montavista kernel stops at the rfi
> instruction which is used to simultanoeusly turn on instruction and data
> address translation and to set the instruction pointer to the (remapped)
> start_here label. Unfortunately I lost my PPC hardware (405GP Walnut
> board) before I could find any solution.
>

	I meet same problem now.When I add CONFIG_MODULES into config file
HHL 2.2.14 works well(my borad is mpc850),but after add it ,I meet same
situation :after uncompressing kernel ,it do noting.It shoud display
LINUX_BANNER.
	If you find the solution,tell me.Thanks.

Dross


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
