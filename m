Message-Id: <200001141101.MAA30605@denx.local.net>
To: dony <dony.he@huawei.com.cn>
Cc: linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross-compile Applications for 860 on x86 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 14 Jan 2000 16:31:49 +0800."
             <387EDEF5.DBD612FA@huawei.com.cn>
Date: Fri, 14 Jan 2000 12:01:08 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <387EDEF5.DBD612FA@huawei.com.cn> you write:
> 
>      When I compile the SASH  with "-static" options and then replace /bin/sh with sash.
> When reseting my MPC860 based board, the kernel boot normally and can show the boot messages. But at last it
> cannot show the "bash#" prompt. If I input "ls" or such commands,

"sash" is the standalone shell, not bash; it  will  display  a  ">  "
prompt - not "bash# ".

> It justs shows :
> 
>     ls
>     pid 8: killed (signal 11)

Maybe you have a problem  with  you  shared  libraries.  Try  running
statically  link  versions  of  some  programs first. Does this work?
[Well, it should when you be able to run a shell...]

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Drun'? 'm not drun'! You woudn' dare call m' drun' if I was sober!
                                     - Terry Pratchett, _Men at Arms_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
