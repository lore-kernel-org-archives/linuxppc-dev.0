MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: Cross compiling for VxWorks/PowerPC Target from a Linux/x86 Machine
Date: Tue, 13 Jul 2004 07:35:29 -0600
Message-ID: <065ACD8E84315E4394C835E398C8D5EB0922AB@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Arun
> Prasad Velu
> Sent: Tuesday, July 13, 2004 12:47 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Cross compiling for VxWorks/PowerPC Target from a Linux/x86
> Machine
>
>
>
> Hello,
>
> I'd like to know how feasible is it to cross compile for a
> VxWorks/PowerPC
> Target from a Linux/x86 Machine?
> If there was any attempt earlier, I'd like to know about it
> (basically to
> get the source compiled for VxWorks/PowerPC from Linux/x86 machine).
> Any pointer on how to go about it would also be appreciated.
>
> Thanks and Regards
> Arun


A co-worker get the cross compiler source from WindRiver and built it under linux.  I wasn't involved and don't know any answers, but he said it was straight forward.  Note that "straight forward" does _not_ mean effortless, depending on your level of expertise, this will take between a day and forever, probably averaging 3-5 days.  This gets you everything you need to compile and link.

WindRiver's proprietary tools (their debugger and configuration system) aren't included, so you have to create your configuration (or at least an initial configuration) using their Windows/Solaris tools -- this produces prjConfig.h (IIRC) configuration file which you then copy to your linux platform and which you can edit by hand if you wish to reconfigure without Windows.  You can use gdb to debug (takes some effort to understand how to make it work) or use other methods (e.g. print statements) -- I generally use print statements.

Building on linux is vastly superior to the gross bloated IDE, but I'm biased -- I hate IDEs.

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
