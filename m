From: Tom Harrington <tph@rmi.net>
Message-Id: <199901250114.SAA21010@shell.rmi.net>
Subject: Re: mac-on-linux project status
To: samuel@ibrium.se (Samuel Rydh)
Date: Sun, 24 Jan 1999 18:14:11 -0700 (MST)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v03130301b2d040f84476@[192.168.0.1]> from "Samuel Rydh" at Jan 24, 99 04:48:41 am
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 4. Status of Hardware Emulation
> 
> The processor emulation is fairly complete, with some  exceptions:
> 
>   - floating point instructions
>   - 603 support
>   - HIDx registers
> 
> Some things in the MMU code needs to be fixed and tuned,  but the MMU
> emulaton is in principle complete.

Just out of curiosity, have you considered using PSIM?  It sounds like
it's a pretty complete PowerPC emulator.  
<ftp://cambridge.cygnus.com/pub/psim/index.html>.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
