Message-Id: <200011151433.JAA93259@p2.parker.boston.ma.us>
To: Ian Abbott <abbotti@mev.co.uk>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: I2C problems 
In-reply-to: Your message of "Wed, 08 Nov 2000 15:38:51 GMT."
             <00933BFA237CD2119B3400409543582704A282@MEV01>
Date: Wed, 15 Nov 2000 09:33:28 -0500
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


fyi: I created a working i2c driver for the 8xx family for Dan a week
or two ago.  It's in the 2_5 tree as I recall.  It's integrated with
the existing i2c code and should work reasonably well.

-brad

Ian Abbott wrote:
>
>Hi folks,
>
>I've been working on a 'Simon Vogl' type I2C driver for MPC8xx (i.e. the
>new I2C interface in the 2.4.0 kernels) based on the work by Dan Malek,
>Kim Jorgensen and Dan Winkler.
>
>My driver only works in master mode. So far I have only been testing it

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
