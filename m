Message-Id: <199904100854.DAA08011@lists.linuxppc.org>
Date: Sat, 10 Apr 1999 04:53:44 -0400
From: "L. S." <lxcom@operamail.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: RE: Uhh...Where Is The Source?
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks, All.

I now understand why I can't find the source files. Since the rpm-related man 
pages seemed misleading to me (--rebuild), and while waiting for more 
responses, I've been viewing uncompressed ".tar.gz" files on the Mac side. 
Therefore, and I haven't tried the various hints and directions yet. I'll boot 
over.

Thanks.
L. S.

>===== Original Message From puetzk6715@uni.edu =====
>Yes, this is a redhat thing. Though you can (as you fond out) use .tgz,
>srpms include all patch files, etc a nd a spec so the system can usually
>auto-build the software
>
>ie, rpm --rebuild will take an SRPM and make a binary RPM from it.
>
>rpm -bp will unpack it for you to play with in /usr/src/redhat/BUILD/
>
>On Wed, 7 Apr 1999, L. S. wrote:
>
>>
>> I can't find any source code for the LinuxPPC applications. I've been going
>> around in circles trying to find ".c" files for fetchmail, sendmail, vim, 
etc.
>> Every directory in /src, /etc, and such seems to have an "SRPMS" or "RPMS"
>> directory in it which, themselves have "SRPMS" and "RPMS" 
directories...which
>> makes me confused.
>> For comparison, I checked around on the internet for other Linux packages 
and
>> found the source files as ".tar.gz" files. I also did see some kernel code 
on
>> my machine, but not all of the other code.
>>
>> What's with all the same-name directories in different locations? Where
>> exactly is the source? Is this a Red Hat thing?
>>
>> I feel like I'm lost in a large amusement park and going around in circles.
>>
>> Yes, I'm pretty new here.
>>
>> L. S.
>>
>> :-| :-) ;-) :-)
>> *

:-| :-) ;-) :-)
*


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
