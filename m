Date: Fri, 24 Jan 2003 00:42:50 -0500 (EST)
From: jgdon <jgdon@gomba.ca>
To: James Don <JDon@spacebridge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Question: insmod QM_MODULES
In-Reply-To: <DB0585C9F6F9D411BE8F00D0B7896A4CC060FF@SNCMAIL>
Message-ID: <Pine.LNX.4.50.0301240039100.15146-100000@gomba.ca>
References: <DB0585C9F6F9D411BE8F00D0B7896A4CC060FF@SNCMAIL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I think the fact my include/config/modules.h had the #undef CONFIG_MODULES
...

After menu config ... my build didn't seem to call the build rule ...

include/config/MARKER: scripts/split-include include/linux/autoconf.h
	scripts/split-include include/linux/autoconf.h include/config
	@ touch include/config/MARKER

Calling the script by hand seemed to fix my problem ...

I will try and find out why later ... for now i'll rebuild and test insmod
... I hope thats it ...

Regards,
Jim




On Thu, 23 Jan 2003, James Don wrote:

>
> Hi,
>
> I am having troubles loading a simeple module with my 2.4.20pre8 kernel from
> m-vista on my ppc custom board (similar to fads).
>
> I keep getting the message:
> 	insmod: QM_MODULES : Function not implemented
>
> I have done a whole bunch of reading and I think I have all my basis
> covered:
>
> 1.) kernel has module support compiled in ...
> 2.) I am using modutils 2.4.20 ...
> 3.) after compiling in module support I rebuilt ulibc to be safe ...
>
> >From what I have read any kernel newer than 2.1 should have support for
> "query on modules" ...
>
> Any enlightenment would be much appreciated,
> Jim
>
> Ps weird fact despite the fact I have compile in modules in my
> include/config/modules.h file there is a undef CONFIG_MODULES ... which
> seems weird to me ... could this be a hint ... should I do a make clean then
> make dep ... or is make dep then make zImage ok normally?
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
