Return-Path: <dalang@cs.ubc.ca>
Received: from mail-relay1.cs.ubc.ca (mail-relay1.cs.ubc.ca [142.103.6.79])
	by ozlabs.org (Postfix) with ESMTP id 1D8B46872B
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2005 15:07:28 +1100 (EST)
Date: Wed, 16 Nov 2005 19:32:03 -0800 (PST)
From: Dustin Lang <dalang@cs.ubc.ca>
To: Felix Oxley <lkml@oxley.org>
In-Reply-To: <200511170213.16926.lkml@oxley.org>
Message-ID: <Pine.LNX.4.60.0511161918050.29361@tin.icics.ubc.ca>
References: <200511170213.16926.lkml@oxley.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [REQUEST] Tap for right click on PowerBook trackpad
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

On my PowerBook, I map F11 to the middle mouse button and F12 to the right 
mouse button.  I've grown so used to it that I get annoyed when it doesn't 
work in OSX :)

You can do the same by:
-be sure to enable CONFIG_MAC_EMUMOUSEBTN in the kernel config
-at startup time (or whenever):
   echo "1" > /proc/sys/dev/mac_hid/mouse_button_emulation
   echo "87" > /proc/sys/dev/mac_hid/mouse_button2_keycode
   echo "88" > /proc/sys/dev/mac_hid/mouse_button3_keycode

Cheers,
dstn.


> One big reason that I don't use Linux on my PowerBook (1.25 AlBook) is 
> the difficulty of using the single button trackpad. Under OS X I use 
> SideTrack which provides the ability to tap for right-click. I did some 
> investigation a few months ago and could not find a Linux replacement 
> for SideTrack.
>
> Would this be a difficult feature to implement?
> Would any one be interested in doing it? :-)
>
> (Please CC me as I am not subscribed)
> regards,
> Felix
