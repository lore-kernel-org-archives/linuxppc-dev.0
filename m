Date: Tue, 13 Apr 1999 23:19:45 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Simone Piccardi <piccardi@fi.infn.it>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC on a Motorola MVME2400
In-Reply-To: <371338D4.4FCAF400@fi.infn.it>
Message-ID: <Pine.LNX.3.96.990413231440.12330L-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 13 Apr 1999, Simone Piccardi wrote:

> thanks for the info. I was trying to build the cross-compiler (so still
> I do not even try to boot the system). I look at your page, but I find a
> broken link for binutils. 

I fixed the build instructions on my page for binutils and egcs, but have
not tested or updated the binary packages to match yet.  glibc
instructions are not updated at this time because alpha.gnu.org is down
and I can't verify the latested glibc version.

> I have also another question, I'm using RedHat 5.2 that has egcs 1.0.3
> (but not for gcc, must I switch to Debian?). 
> I find some rpm for egcs 1.1.2, but in the page you are using 1.1.1,
> must I find this release ? 

My page was just outdated.  I've been using the older versions since I'm
just working kernel issues and it is has been faster to build kernels on
an available PII/400.  rpms for egcs you're finding are most likely native
compilers.  There is no need to switch dists.  Also, I will update my
binary packages soon and the Debian should be available on the next
official Debian release.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
