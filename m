Message-Id: <9909012147.AA27400@marc.watson.ibm.com>
To: Scott Wood <scott@broadlink.com>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: GLIBC wont compile for MPC860 
In-Reply-To: Message from Scott Wood <scott@broadlink.com>
   of "Wed, 01 Sep 1999 13:27:55 PDT." <37CD8C4B.43C595EE@broadlink.com>
Date: Wed, 01 Sep 1999 17:47:00 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Scott Wood writes:

Scott> Graham Stoney wrote:
>> 
>> Scott Wood writes:
>> > The MPC8xx have no floating point, so it should be compiled with -msoft-float,
>> > (I think)...  ./configure --without-fp  will do it.
>> 
>> Is this implied when gcc has been configured --with-cpu=860?

Scott> I don't think so...  I put -msoft-float into the sysdeps/powerpc/Makefile and I see
Scott> it twice below, so I would imagine that if you use both flags then -msoft-float
Scott> will be used.

	Unfortunately, the people who wrote PowerPC support for glibc did
not create a sysdeps/powerpc/fpu directory containing FP-specific code.
There currently is no way to disable FP code in glibc-2.1, but I believe
that the maintainers were suppose to fix this for glibc-2.2; I do not know
about the status.  People who have been working on Linux for embedded
processors have been building glibc somehow, but I do not know the details.

David
===============================================================================
David Edelsohn                                      T.J. Watson Research Center
dje@watson.ibm.com                                  P.O. Box 218
+1 914 945 4364 (TL 862)                            Yorktown Heights, NY 10598

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
