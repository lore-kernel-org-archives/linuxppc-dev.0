Date: Fri, 17 Mar 2000 13:15:02 -0700 (MST)
From: Stephen Edie <sedie@terraplex.com>
To: "James B. Parker" <pajama1@mindspring.com>
cc: LinuxPPC Developer <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Auto update
In-Reply-To: <B4F7F037.1C37%pajama1@mindspring.com>
Message-ID: <Pine.LNX.4.10.10003171310480.9903-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


James,

Yellow Dog Linux contains a program called 'YUP' (Yellow dog Update
Program) which has some of the functionality that you are interested in.
It is a work in progress so there's still some things to be worked out in
it, however, it does get the job done.

YUP works with Champion Server 1.2 and should be easily ported to other
RPM based distributions.  Vendors do need to run the archive generation
program in their FTP distribution in order for YUP to be able to update
from it.

Stephen

Terra Soft Solutions, Inc.
 Yellow Dog Linux
 "The Ultimate Companion for a Dedicated Server"
 http://www.yellowdoglinux.com/

 Black Lab Linux
 Workstations and advanced, Parallel Solutions
 http://www.blacklablinux.com/

On Fri, 17 Mar 2000, James B. Parker wrote:

>
> Is there some sort of auto-update feature in Linux?
> Like some program I can run that checks my currently installed package
> versions versus what is available and informs me if a newer version exists?
> Or should I just memorize the version of every package I have installed?
>
> How do others handle this?
>
> See ya!
> James B. Parker
>
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
