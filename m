Message-Id: <200007292254.XAA08181@hyperion.valhalla.net>
Date: Sat, 29 Jul 2000 23:55:02 +0100
Subject: FW: 2.4.0-test5 :-((((
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Was meant to be off-list (but your return e-mail gives:

   ----- The following addresses had permanent fatal errors -----
<schmitz@opal.biophys.uni-duesseldorf.de>

)

> Thanks Michael,
>
> [snip]
>>> Works OK once we get to init 5 and the Xserver is up (Xpmac rev 10).
>>
>> Broken default keymap - lowercase a on Mac ADB keyboards is keycode 0
>> which is used for some special purpose internally in the keyboard driver.
>> Once some keytable gets loaded, the key should be remapped.
>>
>> In that case it should also work if you boot into any other runlevel
>> without X.
>
> I guess I could have a look at what the runlevel 5 mapping is using...
>
> Trouble is, I was trying to work on something else :-) [and going to try
> Geert's offb patch - because I've got an IMSTT to try it on...]  never mind
> - another day...
>
>> Assuming you're talking about a Powermac with ADB keyboard,
>
> Yes.
>
>> and the
>> keyboard driver still reserves keycode 0 for some ioctl purpose in 2.4.0 -
>> haven't looked at the code in a while (and I think I hacked keyboard_input
>> to remap 'a' to some unused keycode for m68k, but Paul might not have
>> accepted that patch for PPC).
>
> Hmmm. well (I *think*) it was OK at -test4 (not sure now).
>
> But the other breakage (HFS) is more serious for me... just takes too long
> to keep rebuilding the system...
>
> Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
