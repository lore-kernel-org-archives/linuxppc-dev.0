From: "Ashwin Bihari" <raz0redge@hotmail.com>
To: wd@denx.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Embedded initrd with static programs
Date: Tue, 23 Dec 2003 11:00:38 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY9-F56XV5A4zc3F5Y0004672e@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> >
> > So basically I need the other two programs also statically compiled,
>does
> > anyone of any idea on how I would go about this??
>
>Edit the relevant Makefile and add "-static" to the compiler options?
>
>Best regards,
>
>Wolfgang Denk
>

Wolfgang,

I finally found the sources for this sucker and have got the e2fsprogs
statically compiled, working on util-linux. Thanks. :)

_________________________________________________________________
Enjoy the holiday season with great tips from MSN.
http://special.msn.com/network/happyholidays.armx


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
