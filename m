Message-ID: <3E9300E5.6040102@mvista.com>
Date: Tue, 08 Apr 2003 12:03:33 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: glibc vs. newlib
References: <F0B628F30F48064289D8CCC1EE21B7A80C4869@mvebe001.americas.nokia.com> <3E8E31AD.3050302@mvista.com> <20030407014717.GA742@dd.nec.com.au> <3E911523.5050607@mvista.com> <Pine.LNX.4.52.0304081831450.3191@mag.devdep.sysgo.de> <3E92F880.8080500@mvista.com> <3E92FABD.8050307@imc-berlin.de>
In-Reply-To: <3E92FABD.8050307@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:
> Mark Hatle wrote:
>
>> ... So short answer, running a glibc "optimizer" which re-links the
>> original glibc
>> .o files is absolutly safe and supportable.. you just have to
>> understand what it
>> means and how it works to decide if it is right for your application.
>>
>
> Could you recommend one specific open source glibc "optimizer", please?
>
> Maybe even with a URL... :o)

Sorry I don't have an URL, but the one I know of at the top of my head is part
of Debian.  They use it to shrink the size of glibc for their install disks.
Check out "freshmeat.net", I know there are more then one of them out there.

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
