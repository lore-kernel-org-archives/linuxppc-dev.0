Message-ID: <XFMail.990302122222.hcaley@loomer.com>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <4.2.0.25.19990302191548.03a646a0@mail.lauterbach.com>
Date: Tue, 02 Mar 1999 12:22:22 -0500 (EST)
From: Batmensch <hcaley@loomer.com>
To: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: strdup and pre-R5
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thank you for the feedback.  I don't really have any development
background...how would you pass these options ?

Hugh

On 02-Mar-99 Franz Sirl wrote:
> At 04:29 02.03.99 , Batmensch wrote:
> 
>>I'm having a problem building OpenLdap 1.2 on a pre-R5 installation; the
>>error
>>seems to be with strdup(); the make complains :
>>
>>"In file included from args.c:22:
>>../../include/ac/string.h:49 macro `strdup' using without args"
>>
>>I've been able to build it without error on both LinuxPPC 4 and Linux X86.
>>Also the build of 1.0.2 that is included with the R5 distribution seems to 
>>work
>>properly.
>>
>>Anything i can do about this?
> 
> This is a common problem with glibc-2.1, the str... functions are macros 
> and so some silly sources break on "extern str...()" declarations.
> 
> Possible solutions:
> - correct source
> - compile with -D__NO_STRING_INLINES
> - compile with -Os
> 
> Franz.
> 

----------------------------------
E-Mail: Batmensch <hcaley@loomer.com>
Date: 02-Mar-99
Time: 12:20:50

This message was sent by XFMail
----------------------------------

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
