Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3BD5E62D.8000807@oerlikon.ca>
Date: Tue, 23 Oct 2001 17:50:37 -0400
From: Sebastien Ruel <sruel@oerlikon.ca>
Reply-To: sruel@oerlikon.ca
MIME-Version: 1.0
To: Scott Anderson <scott_anderson@mvista.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: RPX-CLLF & Flash root filesystem
References: <3BD5C0B1.2060601@oerlikon.ca> <3BD5D6F6.1C103CBE@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Scott,
initrd.txt is only part of the answer. I'm missing info on how to tell
Linux where to fetch the root filesystem.
Once a minimal/functional root filesystem has been created (and
compressed), you have to put it somewhere in the Flash memory (just like
the Linux image).
When the system boots, it needs to "see" this root filesystem that is
inside the flash.

I will continue to experiment different things.


Scott Anderson wrote:

>Sebastien Ruel wrote:
>
>>Is there a procedure out there that could help me do this?
>>
>
>Is the description in linux/Documentation/initrd.txt what you are
>looking for?
>
>    Scott Anderson
>    scott_anderson@mvista.com   MontaVista Software Inc.
>    (408)328-9214               1237 East Arques Ave.
>    http://www.mvista.com       Sunnyvale, CA  94085
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
