From: Steffen Haeuser <SteffenH@hyperion-software.de>
Reply-To: SteffenH@hyperion-software.de
To: Takashi Oe <toe@unlserve.unl.edu>
CC: linuxppc-dev@lists.linuxppc.org
Date: Sun, 30 Jul 2000 12:27:01 +0100
Message-ID: <yam8246.90.146624920@mail.lf-online.de>
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000729174054.1508B-100000@ofey.inetnebr.com>
Subject: Re: LinuxPPC X Server
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am 29-Jul-00 schrieb Takashi Oe:

>On Sat, 29 Jul 2000, Steffen Haeuser wrote:

Hi!

>> - A bugfix so that Fullscreen 640x480
>>   works

>What bug?  What is not working for you?  On what hardware?  For both
>hardware I own (control and matrox), it is working just fine.

If I use VidModeExtension at first modes which are entered in XF86Config
are entered as 640x481 (but this is of course a minor problem and can be
workarounded). The big problem is that the Screen is totally messed up, looks
to me as if the Bytes_Per_Line are not correct. With 1024x768 it works
correct, but with no other resolutions (and 1024x768 is too slow for the
software renderer of the game, I need 640x480). The Hardware is a
"Blue/White" G3 Mac 1st Revision with (naturally) ATI Rage Graphics
Hardware. I am using the ATI Rage Driver.

>> - A likely timeframe for first 3D Drivers
>>   to be released, which optimally should
>>   not be more than 3 months from now

>Again, what is not working for you?  What have you tried to get them
>working for you and how did it fair?

I cannot try getting something to work what does not exist. And appearently
there are no GLX- or DRI-Drivers for ATI Rage (or any other hardware) yet.
I am talking about Hardware Accelerated Mesa3D here...

Steffen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
