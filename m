From: "Ashwin Bihari" <raz0redge@hotmail.com>
To: Aron.J.Silverton@motorola.com, beena@gdatech.com, dank@kegel.com
Cc: listmember@orkun.us, linuxppc-embedded@lists.linuxppc.org
Subject: RE: Cross-compile package combinations
Date: Tue, 16 Dec 2003 14:34:35 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY9-F64wEC1pxHVmu200077e21@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I was referring to the kernel headers used to build the tools as opposed to
>the building of the actual kernel.  I'll have to look through the crosstool
>scripts, but I'd guess that if the file already exists, it won't download
>it.  I'll probably bump up the version on my kernel to match what crosstool
>wants to see and then put it in the location that I specified in my
>crosstool configuration.
>
>Thanks,
>
>Aron

Aron,

Ahh my bad! :) There is a kernel header define that you can set. On the
version of crosstool I used, they were on top of that file. I just manually
pointed it to the kernel source/headers I had and it was happy.

~Ashwin

_________________________________________________________________
Get holiday tips for festive fun.
http://special.msn.com/network/happyholidays.armx


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
